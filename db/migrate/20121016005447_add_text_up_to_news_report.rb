class AddTextUpToNewsReport < ActiveRecord::Migration
  def change
    add_column :news_reports, :text_up, :boolean
  end
end
