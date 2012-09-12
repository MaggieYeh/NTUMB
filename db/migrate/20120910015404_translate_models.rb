class TranslateModels < ActiveRecord::Migration
  def up
    NewsReport.create_translation_table!(
        {:title => :string, :content => :text},
        {:migrate_data => true}
    )
    Document.create_translation_table!(
        {:discription => :text},
        {:migrate_data => true}
    )
    Announcement.create_translation_table!(
        {:name => :string, :content => :text},
        {:migrate_data => true}
    )
  end

  def down
    NewsReport.drop_translation_table! :migrate_data => true
    Document.drop_translation_table! :migrate_data => true
    Announcement.drop_translation_table! :migrate_data => true
  end
end
