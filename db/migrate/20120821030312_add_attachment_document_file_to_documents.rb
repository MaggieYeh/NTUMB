class AddAttachmentDocumentFileToDocuments < ActiveRecord::Migration
  def self.up
    change_table :documents do |t|
      t.has_attached_file :document_file
    end
  end

  def self.down
    drop_attached_file :documents, :document_file
  end
end
