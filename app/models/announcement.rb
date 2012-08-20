class Announcement < ActiveRecord::Base
  before_validation :check_empty_departments

  attr_accessible :announce_date, :content, :due_date, :name
  attr_accessible :department_ids
  attr_accessible :category_id

  has_many :announcings
  has_many :departments, :through => :announcings
  belongs_to :category, :class_name => 'AnnounceCategory'

  scope :active, lambda { where("announce_date <= ? AND due_date >= ?", Date.today, Date.today )}
  scope :out_of_date, lambda { where("due_date < ?", Date.today) }
  scope :not_announced_yet, lambda { where("announce_date > ?", Date.today) }
  
private
  def check_empty_departments
    if self.department_ids == [] || self.department_ids == nil
      self.departments = Department.all
    end
  end
end
Department.all.each do |department|
  Announcement.instance_eval %Q{
    def #{department.name}
      Department.find_by_name("#{department.name}").announcements.order("updated_at DESC")
    end
    def #{department.name.downcase}
      Department.find_by_name("#{department.name}").announcements.order("updated_at DESC")
    end
    def #{department.name.upcase}
      Department.find_by_name("#{department.name}").announcements.order("updated_at DESC")
    end
  }
end
