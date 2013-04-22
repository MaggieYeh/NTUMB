# encoding: utf-8
class TeacherTitle < ActiveRecord::Base
  #TITLES_en = %w[chairperson distinguished_chair visiting honory proffesor associate assistant adjunct adjunct_associate adjunct_assistant professional_practice_teacher]
  TITLES_en = ["Chair Person", "Distinguished Chair Professor", "Visiting Professor", 
               "Emeritus Professor", "Professor", "Associate Professor", "Assistant Professor",
               "Adjunct Professor", "Adjunct Associate Professor", "Adjunct Assisitant Professor",
               "Professional Practice Teacher", "Adjunct Instructor"]
  TITLES_zh = %w[系主任 特聘講座教授 客座教授 名譽教授 專任教授 專任副教授 專任助理教授 兼任教授 兼任副教授 兼任助理教授 專業實務教師 兼任講師]
  attr_accessible :title_name, :teacher_order, :translations_attributes
  has_many :teachers

  translates :title_name, :fallbacks_for_empty_translations => true
  class Translation
    attr_accessible :locale, :title_name
  end

end
