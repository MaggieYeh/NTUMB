class AddAnnouncementIdToAnnounceCategory < ActiveRecord::Migration
  def change
    add_column :announce_categories, :announcement_id, :integer
  end
end
