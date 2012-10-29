class TranslateTeacherTitle < ActiveRecord::Migration
  def up
    TeacherTitle.create_translation_table!(
      {title_name: :string},{migrate_data: true}
    )
  end

  def down
    TeacherTitle.drop_translation_table! migrate_data: true
  end
end
