class AddFrontEndOrderToTeacher < ActiveRecord::Migration
  def change
    add_column :teachers, :front_end_order, :integer
  end
end
