class CreateAnnounceCategories < ActiveRecord::Migration
  def change
    create_table :announce_categories do |t|
      t.string :name

      t.timestamps
    end
  end
end
