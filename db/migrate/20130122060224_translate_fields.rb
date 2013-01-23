class TranslateFields < ActiveRecord::Migration
  def up
    HomePageTabField.create_translation_table!({
      first_name: :string,
      last_name: :string
    },{
      migrate_data: true
    })
  end

  def down
    HomePageTabField.drop_translation_table! migrate_data: true
  end
end
