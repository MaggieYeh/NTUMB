class CreateSubPages < ActiveRecord::Migration
  def change
    create_table :sub_pages do |t|
      t.text :content
      t.string :title
      t.integer :page_id
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
