class AddDepartmentIdToCarousel < ActiveRecord::Migration
  def change
    add_column :carousels, :department_id, :integer
  end
end
