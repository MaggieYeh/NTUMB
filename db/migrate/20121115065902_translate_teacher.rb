class TranslateTeacher < ActiveRecord::Migration
  def up
    Teacher.create_translation_table!({
      :name => :string,
      :room => :string
    }, {
      :migrate_data => true
    })
  end

  def down
    Teacher.drop_translation_table! :migrate_data => true
  end
end
