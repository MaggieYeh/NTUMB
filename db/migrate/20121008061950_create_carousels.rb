class CreateCarousels < ActiveRecord::Migration
  def change
    create_table :carousels do |t|
      t.string :title
      t.string :link_url
      t.text :caption

      t.timestamps
    end
  end
end
