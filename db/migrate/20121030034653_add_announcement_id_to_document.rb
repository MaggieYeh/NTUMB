class AddAnnouncementIdToDocument < ActiveRecord::Migration
  def change
    add_column :documents, :announcement_id, :integer
  end
end
