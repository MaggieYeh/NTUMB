class Announcement < ActiveRecord::Base
  before_validation :check_empty_departments

  attr_accessible :content, :due_date, :name #,announce_date
  attr_accessible :department_ids
  attr_accessible :category_id

  has_many :announcings
  has_many :departments, :through => :announcings
  belongs_to :category, :class_name => 'AnnounceCategory'

  attr_accessible :translations_attributes
  translates :content, :name, :fallbacks_for_empty_translations => true
  class Translation
    attr_accessible :locale, :content, :name
  end
  accepts_nested_attributes_for :translations

  def announce_date
    self.created_at.to_date
  end

  #scope :active, lambda { where("announce_date <= ? AND due_date >= ?", Date.today, Date.today )}
  scope :active, lambda { where("due_date >= ?", Date.today )}
  scope :out_of_date, lambda { where("due_date < ?", Date.today) }
  #scope :not_announced_yet, lambda { where("announce_date > ?", Date.today) }
  
private
  def check_empty_departments
    if self.department_ids == [] || self.department_ids == nil
      self.departments = Department.all
    end
  end
end
Department.pluck("name").each do |department_name|
  Announcement.instance_eval %Q{
    def #{department_name}
      Department.find_by_name("#{department_name}").announcements.order("updated_at DESC")
    end
    def #{department_name.downcase}
      Department.find_by_name("#{department_name}").announcements.order("updated_at DESC")
    end
    def #{department_name.upcase}
      Department.find_by_name("#{department_name}").announcements.order("updated_at DESC")
    end
  }
end
