class Teacher < ActiveRecord::Base
  acts_as_paranoid
  attr_accessible :cellphone, :department_id, :email, :homepage, :name, :phone,
                  :tax_number, :avatar, :teacher_title_id, :room, :joint_with, :front_end_order,
                  :picked_by_emba, :picked_by_gmba
  attr_accessible :educational_backgrounds_attributes
  attr_accessible :courses_attributes
  attr_accessible :research_areas_attributes
  has_attached_file :avatar
  has_many :research_areas, :through => :researchings
  has_many :researchings
  has_many :courses
  has_many :educational_backgrounds

  scope :picked_by_emba, lambda { where(picked_by_emba: true) }
  scope :picked_by_gmba, lambda { where(picked_by_gmba: true) }

  belongs_to :admin_user
  belongs_to :department
  belongs_to :teacher_title

  attr_accessible :translations_attributes
  translates :honor, :history, :name, :room, :fallbacks_for_empty_translations => true
  class Translation
    attr_accessible :locale, :name, :room, :honor, :history
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
