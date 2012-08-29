class CreateTeacherTitles < ActiveRecord::Migration
  def change
    create_table :teacher_titles do |t|
      t.string :title_name

      t.timestamps
    end
  end
end
