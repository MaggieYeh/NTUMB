class CreateSubPageSections < ActiveRecord::Migration
  def up
    create_table :sub_page_sections do |t|
      t.datetime :deleted_at
      t.integer :page_id

      t.timestamps
    end
    SubPageSection.create_translation_table! :section_title => :string
  end
  def down
    drop_table :sub_page_sections
    SubPageSection.drop_translation_table!
  end
end
