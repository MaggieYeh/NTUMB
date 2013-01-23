class CreateAnnounceFieldings < ActiveRecord::Migration
  def change
    create_table :announce_fieldings do |t|
      t.integer :announce_category_id
      t.integer :home_page_tab_field_id

      t.timestamps
    end
  end
end
