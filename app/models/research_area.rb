class ResearchArea < ActiveRecord::Base
  attr_accessible :name
  has_many :teachers, :through => :researchings
  has_many :researchings
  attr_accessible :translations_attributes
  translates :name, :fallbacks_for_empty_translations => true
  class Translation
    attr_accessible :locale, :name
  end
  accepts_nested_attributes_for :translations
end
