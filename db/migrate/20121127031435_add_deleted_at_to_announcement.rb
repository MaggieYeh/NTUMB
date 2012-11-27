class AddDeletedAtToAnnouncement < ActiveRecord::Migration
  def change
    add_column :announcements, :deleted_at, :datetime
  end
end
