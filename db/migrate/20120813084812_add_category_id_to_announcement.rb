class AddCategoryIdToAnnouncement < ActiveRecord::Migration
  def change
    add_column :announcements, :category_id, :integer
  end
end
