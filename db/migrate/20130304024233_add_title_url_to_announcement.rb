class AddTitleUrlToAnnouncement < ActiveRecord::Migration
  def change
    add_column :announcements, :title_url, :string
  end
end
