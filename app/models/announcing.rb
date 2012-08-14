class Announcing < ActiveRecord::Base
  attr_accessible :announcement_id, :department_id
  belongs_to :department
  belongs_to :announcement
end
