class AddDepartmentIdToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :department_id, :integer
  end
end
