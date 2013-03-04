class AddPickedByManagementToAnnouncement < ActiveRecord::Migration
  def change
    add_column :announcements, :picked_by_management, :boolean
  end
end
