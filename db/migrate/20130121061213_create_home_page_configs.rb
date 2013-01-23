class CreateHomePageConfigs < ActiveRecord::Migration
  def change
    create_table :home_page_configs do |t|
      t.integer :department_id
      t.string :contact_info

      t.timestamps
    end
  end
end
