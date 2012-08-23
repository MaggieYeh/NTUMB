class RemoveDocumentFileFromDocuments < ActiveRecord::Migration
  def up
    remove_column :documents, :document_files
  end

  def down
    add_column :documents, :document_files, :string
  end
end
