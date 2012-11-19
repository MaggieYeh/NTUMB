class AddRoomToTeacher < ActiveRecord::Migration
  def change
    add_column :teachers, :room, :string
  end
end
