class FixTabFieldColumnName < ActiveRecord::Migration
  def change
    rename_column :home_page_tab_fields, :fisrt_name, :first_name
  end
end
