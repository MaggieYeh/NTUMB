class AddUseNewwebDataToTeacher < ActiveRecord::Migration
  def change
    add_column :teachers, :use_newweb_data, :boolean
  end
end
