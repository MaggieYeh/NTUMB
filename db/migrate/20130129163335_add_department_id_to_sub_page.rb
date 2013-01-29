class AddDepartmentIdToSubPage < ActiveRecord::Migration
  def change
    add_column :sub_pages, :department_id, :integer
  end
end
