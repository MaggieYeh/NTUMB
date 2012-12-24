class TranslateSubPage < ActiveRecord::Migration
  def up
    SubPage.create_translation_table!({
      :content => :text,
      :title => :string
    },{:migrate_data => true})
  end

  def down
    SubPage.drop_translation_table! :migrate_data => true
  end
end
