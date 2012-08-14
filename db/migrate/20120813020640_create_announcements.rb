class CreateAnnouncements < ActiveRecord::Migration
  def change
    create_table :announcements do |t|
      t.string :name
      t.date :announce_date
      t.date :due_date
      t.text :content

      t.timestamps
    end
  end
end
