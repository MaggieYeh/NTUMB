class Teacher < ActiveRecord::Base
  attr_accessible :cellphone, :department_id, :email, :homepage, :name, :phone, :title_id, :tax_number, :avatar
  attr_accessible :educational_backgrounds_attributes
  attr_accessible :courses_attributes
  attr_accessible :reasearch_areas_attributes
  has_attached_file :avatar
  has_many :research_areas, :through => :researchings
  has_many :researchings
  has_many :courses
  has_many :educational_backgrounds

  belongs_to :admin_user
  belongs_to :department
  belongs_to :title, :class_name => "TeacherTitle"

  accepts_nested_attributes_for :courses, :reject_if => proc { |c| c[:name].blank?},
                                :allow_destroy => true
  accepts_nested_attributes_for :research_areas, :reject_if => proc { |r| r[:name].blank?},
                                :allow_destroy => true
  accepts_nested_attributes_for :educational_backgrounds, :reject_if => proc { |e| e[:name].blank? },
                                :allow_destroy => true

end
