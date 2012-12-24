class PagePart < ActiveRecord::Base
  attr_accessible :deleted_at, :page_id
  acts_as_paranoid
  belongs_to :page

  attr_accessible :translations_attributes
  translates :title, :content, :fallbacks_for_empty_translations => true
  class Translation
    attr_accessible :locale, :title, :content
    acts_as_paranoid
  end
  accepts_nested_attributes_for :translations
end
