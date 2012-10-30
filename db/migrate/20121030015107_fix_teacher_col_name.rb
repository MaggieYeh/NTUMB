class FixTeacherColName < ActiveRecord::Migration
  def change
    rename_column :teachers, :title_id, :teacher_title_id
  end
end
