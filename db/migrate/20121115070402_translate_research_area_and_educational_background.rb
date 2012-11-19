class TranslateResearchAreaAndEducationalBackground < ActiveRecord::Migration
  def up
    EducationalBackground.create_translation_table!({
      :name => :string,
    }, {
      :migrate_data => true
    })
    ResearchArea.create_translation_table!({
      :name => :string,
    }, {
      :migrate_data => true
    })
  end

  def down
    EducationalBackground.drop_translation_table! :migrate_data => true
    ResearchArea.drop_translation_table! :migrate_data => true
  end
end
