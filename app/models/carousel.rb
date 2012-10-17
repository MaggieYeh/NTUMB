class Carousel < ActiveRecord::Base
  attr_accessible :caption, :link_url, :title, :picture, :department_id
  has_attached_file :picture, styles: { medium: "670x400#" }

  scope :recent, proc{|n = 3| order("created_at DESC").limit(n)}

  belongs_to :department
  
end
