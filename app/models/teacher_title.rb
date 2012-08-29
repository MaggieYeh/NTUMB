class TeacherTitle < ActiveRecord::Base
  attr_accessible :title_name
  has_many :teachers, :inverse_of => :title
end
