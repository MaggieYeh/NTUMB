class CreateHomePageTabFields < ActiveRecord::Migration
  def change
    create_table :home_page_tab_fields do |t|
      t.integer :home_page_config_id
      t.string :fisrt_name
      t.string :last_name

      t.timestamps
    end
  end
end
