class AddStickyToAnnouncement < ActiveRecord::Migration
  def change
    add_column :announcements, :sticky, :boolean
  end
end
