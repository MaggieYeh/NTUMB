class AddDeletedAtToHomePageTabField < ActiveRecord::Migration
  def change
    add_column :home_page_tab_fields, :deleted_at, :datetime
  end
end
