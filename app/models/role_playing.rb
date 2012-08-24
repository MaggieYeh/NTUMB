class RolePlaying < ActiveRecord::Base
  attr_accessible :admin_user_id, :role_id
  belongs_to :role
  belongs_to :admin_user
end
