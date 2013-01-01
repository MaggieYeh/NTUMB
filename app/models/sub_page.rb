class SubPage < ActiveRecord::Base
  acts_as_paranoid
  attr_accessible :content, :page_id, :title, :locale
  belongs_to :page
  belongs_to :sub_page_section

  #attr_accessible :translations_attributes
  #translates :title, :content, :fallbacks_for_empty_translations => true
  #class Translation
    #attr_accessible :locale, :title, :content
    #acts_as_paranoid
    ##validates :menu_title, :presence => true
  #end
  #accepts_nested_attributes_for :translations
end
