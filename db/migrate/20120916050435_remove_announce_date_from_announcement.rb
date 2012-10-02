class RemoveAnnounceDateFromAnnouncement < ActiveRecord::Migration
  def up
    remove_column :announcements, :announce_date
  end

  def down
    add_column :announcements, :announce_date, :date
  end
end
