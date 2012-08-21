class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.text :discription
      t.integer :category_id

      t.timestamps
    end
  end
end
