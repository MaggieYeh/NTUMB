class Department < ActiveRecord::Base
  attr_accessible :name, :page_ids, :annoucement_ids
  has_many :pages
  has_many :announcings
  has_many :announcements, :through => :announcings
  cattr_accessor :current_department

end
