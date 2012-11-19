class DropAnnouncing < ActiveRecord::Migration
  def up
    drop_table :announcings
  end

  def down
  end
end
