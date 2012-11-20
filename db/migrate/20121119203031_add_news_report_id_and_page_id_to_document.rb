class AddNewsReportIdAndPageIdToDocument < ActiveRecord::Migration
  def change
    add_column :documents, :news_report_id, :integer
    add_column :documents, :page_id, :integer
  end
end
