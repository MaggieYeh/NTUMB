class AddDeletedAtToNewsReport < ActiveRecord::Migration
  def change
    add_column :news_reports, :deleted_at, :datetime
  end
end
