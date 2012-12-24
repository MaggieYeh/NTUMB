class SubPageSection < ActiveRecord::Base
  attr_accessible :deleted_at, :page_id
  acts_as_paranoid

  belongs_to :page
  has_many :sub_pages

  attr_accessible :sub_pages_attributes
  accepts_nested_attributes_for :sub_pages, :allow_destroy => true

  attr_accessible :translations_attributes
  translates :section_title, :fallbacks_for_empty_translations => true
  class Translation
    attr_accessible :locale, :section_title
    acts_as_paranoid
  end
  accepts_nested_attributes_for :translations
end
