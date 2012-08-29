class AddTaxNumberToTeacher < ActiveRecord::Migration
  def change
    add_column :teachers, :tax_number, :string
  end
end
