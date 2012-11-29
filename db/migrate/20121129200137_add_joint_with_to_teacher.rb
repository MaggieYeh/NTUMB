class AddJointWithToTeacher < ActiveRecord::Migration
  def change
    add_column :teachers, :joint_with, :string
  end
end
