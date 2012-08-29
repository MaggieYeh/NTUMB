class EducationalBackground < ActiveRecord::Base
  attr_accessible :name, :require_year, :teacher_id
  belongs_to :teacher
end
