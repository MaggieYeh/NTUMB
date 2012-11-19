class AddDepartmentIdToAnnouncement < ActiveRecord::Migration
  def change
    add_column :announcements, :department_id, :integer
  end
end
