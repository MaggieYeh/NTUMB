class Course < ActiveRecord::Base
  attr_accessible :name, :teacher_id
  belongs_to :teacher
  attr_accessible :translations_attributes
  translates :name, :fallbacks_for_empty_translations => true
  class Translation
    attr_accessible :locale, :name
  end
  accepts_nested_attributes_for :translations
end
