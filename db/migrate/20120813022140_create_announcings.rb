class CreateAnnouncings < ActiveRecord::Migration
  def change
    create_table :announcings do |t|
      t.integer :announcement_id
      t.integer :department_id

      t.timestamps
    end
  end
end
