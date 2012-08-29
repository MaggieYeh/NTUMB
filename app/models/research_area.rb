class ResearchArea < ActiveRecord::Base
  attr_accessible :name
  has_many :teachers, :through => :researchings
  has_many :researchings
end
