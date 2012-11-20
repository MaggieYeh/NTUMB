#!/bin/env ruby
# encoding: utf-8
class Page < ActiveRecord::Base

  #TODO check reserved word
  # like: url, page, admin, etc
  #

  MODEL_INDEX_PAGES = %w[teachers announcements news_reports documents]
  RESERVED_PATH = MODEL_INDEX_PAGES + %w[url page admin]

  attr_accessible :menu_title, :title, :content, :delegated_to
  attr_accessible :page_part_ids, :url_name, :translations_attributes
  attr_accessible :parent_id
  belongs_to :department

  attr_accessible :documents_attributes
  has_many :documents
  accepts_nested_attributes_for :documents, :reject_if => proc { |d| d[:document_file].blank?},
                                :allow_destroy => true

  translates :menu_title, :title, :content, :fallbacks_for_empty_translations => true
  class Translation
    attr_accessible :locale, :title, :content, :menu_title
    #validates :menu_title, :presence => true
  end
  accepts_nested_attributes_for :translations, :reject_if => proc {|t| t[:menu_title].empty?}

  #validates :title, :presence => true, :unless => :delegated?
  validates :position, :presence => true
  validates :department_id, :presence => true
  validates :url_name, :presence => true

  before_validation :check_department
  before_validation :check_menu_title
  before_validation :give_last_position

  before_save :update_path

  acts_as_nested_set

  scope :delegated, where("delegated_to <> ''")

  def delegated_as_controller_index?
    Page::MODEL_INDEX_PAGES.include?(self.delegated_to)
  end

  def delegated?
    !self.delegated_to.to_s.empty?
  end

  def top_level?
    self.parent.nil?
  end

  def concat_ancestor_names(name = "")
    #name.prepend "/#{menu_title}"
    name.prepend "/#{url_name}"
    if parent
      name = parent.concat_ancestor_names(name)
    end
    name
  end

  def self.to_department_abbr_s
    #department_name = self.class_name.match(/^(.*)Page$/)[1]
    department_name = self.to_s.match(/^(.*)Page$/)[1]
    # == 2 || == 4 is a dirty solution for department name BA IB IM GMBA EMBA
    if department_name.length == 2 || department_name.length == 4
      department_name = department_name.upcase
    end
    department_name
  end

  def self.to_admin_symbol
    self.to_department_abbr_s.downcase.concat("_admin").intern
  end

  def self.nav_list_for(model_name)
    nav_list = []
    if MODEL_INDEX_PAGES.member?(model_name)
      page = self.find_by_url_name(model_name)
      nav_list = ::MyUtils.build_nav_list(page)
    end
    nav_list
  end

  private

  def check_menu_title
    if self.menu_title.to_s.empty?
      self.menu_title = self.url_name
    end
  end

  def give_last_position
    if self.position.nil?
      max = self.class.maximum("position") || 0
      self.position = max + 1
    end
  end

  def check_department
    if self.department_id.nil?
      self.department = Department.find_by_name("Management")
    end
  end

  def update_path
    result = concat_ancestor_names
    self.path = result
  end

end
