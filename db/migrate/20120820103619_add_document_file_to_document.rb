class AddDocumentFileToDocument < ActiveRecord::Migration
  def change
    add_column :documents, :document_file, :string
  end
end
