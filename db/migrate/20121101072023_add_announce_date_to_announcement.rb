class AddAnnounceDateToAnnouncement < ActiveRecord::Migration
  def change
    add_column :announcements, :announce_date, :date
  end
end
