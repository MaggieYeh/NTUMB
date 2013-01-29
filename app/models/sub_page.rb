# encoding: utf-8
class SubPage < ActiveRecord::Base
  acts_as_paranoid
  attr_accessible :content, :page_id, :title, :locale, :department_id
  belongs_to :department
  belongs_to :page
  belongs_to :sub_page_section
  validates_presence_of :department
  validates_presence_of :locale

  def path
    if self.department
      "/#{locale}/#{self.department.name}/sub_pages/#{id}" 
    else
      "/#{locale}/sub_pages/#{id}"
    end
  end

  def department_name
    if self.department
      self.department.name 
    else
      "無"
    end
  end

  #attr_accessible :translations_attributes
  #translates :title, :content, :fallbacks_for_empty_translations => true
  #class Translation
    #attr_accessible :locale, :title, :content
    #acts_as_paranoid
    ##validates :menu_title, :presence => true
  #end
  #accepts_nested_attributes_for :translations
end
::MyUtils.add_department_scopes(SubPage)
