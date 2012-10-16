class AddAttachmentPreviewToNewsReports < ActiveRecord::Migration
  def self.up
    change_table :news_reports do |t|
      t.has_attached_file :preview
    end
  end

  def self.down
    drop_attached_file :news_reports, :preview
  end
end
