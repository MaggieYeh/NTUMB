class Role < ActiveRecord::Base
  attr_accessible :role
  has_many :admin_users, :through => :role_playings
  has_many :role_playings
  ROLES = %w[super_admin ib_admin fin_admin acc_admin im_admin ba_admin gmba_admin emba_admin teacher]
end
