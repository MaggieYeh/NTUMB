class CreateNewsReports < ActiveRecord::Migration
  def change
    create_table :news_reports do |t|
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end
