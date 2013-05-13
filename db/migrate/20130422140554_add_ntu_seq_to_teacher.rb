class AddNtuSeqToTeacher < ActiveRecord::Migration
  def change
    add_column :teachers, :ntu_seq, :string
  end
end
