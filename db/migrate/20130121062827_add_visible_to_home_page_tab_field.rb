class AddVisibleToHomePageTabField < ActiveRecord::Migration
  def change
    add_column :home_page_tab_fields, :visible, :boolean
  end
end
