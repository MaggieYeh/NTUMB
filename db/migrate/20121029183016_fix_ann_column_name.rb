class FixAnnColumnName < ActiveRecord::Migration
  def change
    rename_column :announcements, :category_id, :announce_category_id
  end
end
