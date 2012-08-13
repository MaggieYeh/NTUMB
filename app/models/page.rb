#!/bin/env ruby
# encoding: utf-8
class Page < ActiveRecord::Base
#TODO check reserved word
# like: url, page, admin, etc
  attr_accessible :menu_title, :page_part_ids, :title, :content, :delegated #, :department_id
# For acts_as_nested_set
  attr_accessible :parent_id
  attr_accessible :slug
  belongs_to :department


  #scope :EMBA, where(:department_id => 8)
  Department.all.each do |department|
    self.send( :scope, department.name, 
              where(:department_id => department.id) )
    self.send( :scope, department.name.downcase, 
              where(:department_id => department.id) )
    self.send( :scope, department.name.upcase, 
              where(:department_id => department.id) )
  end
  #default_scope Page.Management

  validates :menu_title, :presence => true
  validates :title, :presence => true
  validates :position, :presence => true
  validates :department_id, :presence => true

  before_validation :check_department
  before_validation :give_last_position
  #before_validation :check_menu_title

  before_save :update_path
  #after_update :update_path

  acts_as_nested_set

  def delegated?
    self.delegated
  end

  def concat_ancestor_names(name = "")
    name.prepend "/#{menu_title}"
    if parent
      name = parent.concat_ancestor_names(name)
    end
    name
  end

  private


  def give_last_position
    if self.position.nil?
      max = Page.send(Department.find(department_id).name).maximum("position") || 1
      self.position =  max + 1
    end
  end

  def check_department
    if self.department_id.nil?
      self.department_id = 1
    end
  end

  def update_path
    result = concat_ancestor_names# + "/#{menu_title}"
    #binding.pry
    self.path = result
  end

end
