class Announcement < ActiveRecord::Base
  attr_accessible :announce_date, :content, :due_date, :name
  attr_accessible :department_ids
  attr_accessible :category_id
  has_many :announcings
  has_many :departments, :through => :announcings
  belongs_to :category, :class_name => 'AnnounceCategory'
  scope :active, lambda { where("announce_date < ? AND due_date > ?", Date.today, Date.today )}
  scope :out_of_date, lambda { where("due_date < ?", Date.today) }
  scope :not_announced_yet, lambda { where("announce_date > ?", Date.today) }
end
