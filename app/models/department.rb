class Department < ActiveRecord::Base
  attr_accessible :name, :page_ids, :annoucement_ids, :news_report_ids,
                  :document_ids, :teacher_ids, :carousel_ids
  has_many :pages
  has_many :news_reports
  has_many :documents
  has_one :home_page_config
  has_many :sub_page

  #has_many :announcings
  #has_many :announcements, :through => :announcings
  has_many :announcements

  has_many :teachers
  has_many :carousels

  cattr_accessor :current_department_name

  DEPARTMENTS = %w[Management BA Acc Fin IB IM EMBA GMBA]
  INTERNATIONAL_AFFAIRS = "IA"
  #DCOLORS = %w[c65152 9a7016 ff9748 5183c7 8465a7 4daecb 13c29f]
  DCOLORS = { "BA" => "c65152", "Acc" => "9a7016",
              "Fin" => "ff9748","IB" => "5183c7",
              "IM" => "8465a7","EMBA" => "4daecb","GMBA" => "13c29f",
              "IA" => "13c29f"}

end
