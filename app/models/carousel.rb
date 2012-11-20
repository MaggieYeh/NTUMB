class Carousel < ActiveRecord::Base
  attr_accessible :caption, :link_url, :title, :picture, :department_id
  has_attached_file :picture, styles: { medium: "670x400#" }
  attr_accessible :translations_attributes
  translates :caption, :title, :fallbacks_for_empty_translations => true
  class Translation
    attr_accessible :locale, :title, :caption
  end
  accepts_nested_attributes_for :translations

  scope :recent, proc{|n = 3| order("created_at DESC").limit(n)}

  belongs_to :department
  
end
::MyUtils.add_department_scopes(Carousel)
#Department::DEPARTMENTS.each do |department_name|
  #Carousel.instance_eval %Q{
    #def #{department_name}
      #Department.find_by_name("#{department_name}").carousels
    #end
    #def #{department_name.downcase}
      #Department.find_by_name("#{department_name}").carousels
    #end
    #def #{department_name.upcase}
      #Department.find_by_name("#{department_name}").carousels
    #end
  #}
#end
