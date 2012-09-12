class NewsReport < ActiveRecord::Base
  attr_accessible :department_id
  belongs_to :department
  attr_accessible :translations_attributes, :content, :title

  translates :title, :content, :fallbacks_for_empty_translations => true
  class Translation
    attr_accessible :locale, :title, :content
  end
  accepts_nested_attributes_for :translations

end
