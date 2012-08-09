class AddDepartmentIdToPage < ActiveRecord::Migration
  def change
    add_column :pages, :department_id, :integer
  end
end
