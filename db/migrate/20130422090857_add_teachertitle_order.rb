class AddTeachertitleOrder < ActiveRecord::Migration
  def change
    add_column :teacher_titles, :teacher_order, :integer, :default => 0
  end
end
