class Course < ActiveRecord::Base
  attr_accessible :name, :teacher_id
  belongs_to :teacher
end
