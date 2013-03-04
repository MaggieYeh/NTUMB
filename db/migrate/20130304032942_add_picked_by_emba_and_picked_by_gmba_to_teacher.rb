class AddPickedByEmbaAndPickedByGmbaToTeacher < ActiveRecord::Migration
  def change
    add_column :teachers, :picked_by_emba, :boolean
    add_column :teachers, :picked_by_gmba, :boolean
  end
end
