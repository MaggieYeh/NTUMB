class AddHonorAndHistoryToTeacherTranslation < ActiveRecord::Migration
  def change
    add_column :teacher_translations, :honor, :text
    add_column :teacher_translations, :history, :text
  end
end
