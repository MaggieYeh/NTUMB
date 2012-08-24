class Role < ActiveRecord::Base
  attr_accessible :role
  has_many :admin_users, :through => :role_playings
  has_many :role_playings
end
