class AddPreviewColorToNewsReport < ActiveRecord::Migration
  def change
    add_column :news_reports, :preview_color, :string
  end
end
