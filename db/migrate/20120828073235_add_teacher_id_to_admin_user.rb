class AddTeacherIdToAdminUser < ActiveRecord::Migration
  def change
    add_column :admin_users, :teacher_id, :integer
  end
end
