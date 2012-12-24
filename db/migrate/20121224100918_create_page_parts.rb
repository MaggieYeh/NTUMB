class CreatePageParts < ActiveRecord::Migration
  def up
    create_table :page_parts do |t|
      t.datetime :deleted_at
      t.integer :page_id

      t.timestamps
    end
    PagePart.create_translation_table! :title => :string, :content => :text
  end
  def down
    drop_table :page_parts
    PagePart.drop_translation_table!
  end
end
