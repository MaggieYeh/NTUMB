class Teacher < ActiveRecord::Base
  acts_as_paranoid
  attr_accessible :cellphone, :department_id, :email, :homepage, :name, :phone,
                  :tax_number, :avatar, :teacher_title_id, :room, :joint_with
  attr_accessible :educational_backgrounds_attributes
  attr_accessible :courses_attributes
  attr_accessible :research_areas_attributes
  has_attached_file :avatar
  has_many :research_areas, :through => :researchings
  has_many :researchings
  has_many :courses
  has_many :educational_backgrounds

  belongs_to :admin_user
  belongs_to :department
  belongs_to :teacher_title

  attr_accessible :translations_attributes
  translates :name, :room, :fallbacks_for_empty_translations => true
  class Translation
    attr_accessible :locale, :name, :room
  end
  accepts_nested_attributes_for :translations

  accepts_nested_attributes_for :courses,# :reject_if => proc { |c| c[:name].blank?},
                                :allow_destroy => true
  accepts_nested_attributes_for :research_areas,# :reject_if => proc { |r| r[:name].blank?},
                                :allow_destroy => true
  accepts_nested_attributes_for :educational_backgrounds,# :reject_if => proc { |e| e[:name].blank? },
                                :allow_destroy => true

end
::MyUtils.add_department_scopes(Teacher)
#(Department::DEPARTMENTS.append(Department::INTERNATIONAL_AFFAIRS)).each do |department_name|
  #Teacher.instance_eval %Q{
    #def #{department_name}
      #Department.find_by_name("#{department_name}").teachers
    #end
    #def #{department_name.downcase}
      #Department.find_by_name("#{department_name}").teachers
    #end
    #def #{department_name.upcase}
      #Department.find_by_name("#{department_name}").teachers
    #end
  #}
#end
