class Announcement < ActiveRecord::Base
  #before_validation :check_empty_departments

  acts_as_paranoid
  attr_accessible :due_date, :announce_date, :sticky, :picked_by_management
  attr_accessible :department_id
  attr_accessible :announce_category_id
  attr_accessible :documents_attributes

  validates :announce_category, presence: true
  validates :department, presence: true

  has_many :announcings
  #has_many :departments, :through => :announcings
  has_many :documents
  belongs_to :announce_category
  belongs_to :department
  accepts_nested_attributes_for :documents, :reject_if => proc { |d| d[:document_file].blank?},
                                :allow_destroy => true

  attr_accessible :translations_attributes
  translates :content, :name, :title_url, :fallbacks_for_empty_translations => true
  class Translation
    attr_accessible :locale, :content, :name, :title_url
    #validates :content, presence: true
    #validates :name, presence: true
  end
  accepts_nested_attributes_for :translations

  #def announce_date
    #self.created_at.to_date
  #end

  def lasting_days
    (self.due_date - announce_date).to_i
  end

  #scope :active, lambda { where("announce_date <= ? AND due_date >= ?", Date.today, Date.today )}
  scope :active, lambda { where("due_date >= ?", Date.today )}
  scope :out_of_date, lambda { where("due_date < ?", Date.today) }
  scope :categories, lambda{|c1,c2| where("announce_category_id = ?",c1) + where("announce_category_id = ?", c2)}
  scope :instant, lambda{ categories(AnnounceCategory.find_by_name("administrative"),AnnounceCategory.find_by_name("events")) }
  scope :student, lambda{ categories(AnnounceCategory.find_by_name("scholarship_and_exchange_student"),AnnounceCategory.find_by_name("enrollments")) }
  scope :jobs, lambda{ categories(AnnounceCategory.find_by_name("intern_opportunities"),AnnounceCategory.find_by_name("enrollments")) }
  scope :recent, lambda{|n| order("announce_date DESC").limit(n)}
  #scope :not_announced_yet, lambda { where("announce_date > ?", Date.today) }
  scope :sticky, where(sticky: true)
  scope :not_sticky, where(sticky: [false,nil])
  
private

  #def check_empty_departments
    #if self.department_id == [] || self.department_id == nil
      #self.department = Department.find_by_name("Management")
    #end
  #end
    
end

::MyUtils.add_department_scopes(Announcement)

#(Department::DEPARTMENTS + Department::INTERNATIONAL_AFFAIRS).each do |department_name|
  #Announcement.instance_eval %Q{
    #def #{department_name}
      #Department.find_by_name("#{department_name}").announcements
    #end
    #def #{department_name.downcase}
      #Department.find_by_name("#{department_name}").announcements
    #end
    #def #{department_name.upcase}
      #Department.find_by_name("#{department_name}").announcements
    #end
  #}
#end
