class PublicationType < ActiveRecord::Base
  attr_accessible :name
  has_many :newweb_teacher_publications
end
