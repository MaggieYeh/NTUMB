class Researching < ActiveRecord::Base
  attr_accessible :research_area_id, :teacher_id
  belongs_to :teacher
  belongs_to :research_area
  accepts_nested_attributes_for :research_area
end
