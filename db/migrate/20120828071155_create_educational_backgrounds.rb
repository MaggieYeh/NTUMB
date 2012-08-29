class CreateEducationalBackgrounds < ActiveRecord::Migration
  def change
    create_table :educational_backgrounds do |t|
      t.string :name
      t.string :require_year

      t.timestamps
    end
  end
end
