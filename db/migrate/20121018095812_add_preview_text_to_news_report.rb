class AddPreviewTextToNewsReport < ActiveRecord::Migration
  def change
    add_column :news_reports, :preview_text, :string
  end
end
