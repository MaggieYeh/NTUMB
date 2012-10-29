class FixDocColumnName < ActiveRecord::Migration
  def change
    rename_column :documents, :category_id, :document_category_id
  end
end
