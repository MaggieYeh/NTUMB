class AddAnnounceDateToNewsReport < ActiveRecord::Migration
  def change
    add_column :news_reports, :announce_date, :date
  end
end
