class AddTeacherIdToEducationalBackground < ActiveRecord::Migration
  def change
    add_column :educational_backgrounds, :teacher_id, :integer
  end
end
