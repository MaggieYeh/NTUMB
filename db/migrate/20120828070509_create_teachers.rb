class CreateTeachers < ActiveRecord::Migration
  def change
    create_table :teachers do |t|
      t.integer :admin_user_id
      t.integer :department_id
      t.string :name
      t.string :phone
      t.string :cellphone
      t.integer :title_id
      t.string :email
      t.string :homepage

      t.timestamps
    end
  end
end
