class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title
      t.string :menu_title
      t.integer :page_part_ids
      t.integer :rgt
      t.integer :lft
      t.integer :depth
      t.integer :parent_id
      t.string :slug

      t.timestamps
    end
  end
end
