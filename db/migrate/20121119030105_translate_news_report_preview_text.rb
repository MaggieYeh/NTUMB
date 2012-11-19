class TranslateNewsReportPreviewText < ActiveRecord::Migration
  def up
    change_table(:news_report_translations) do |t|
      t.string :preview_text
    end
  end

  def down
    remove_column :news_report_translations, :preview_text
  end
end
