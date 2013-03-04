class AddOldLinkToHomePageConfig < ActiveRecord::Migration
  def change
    add_column :home_page_configs, :old_link, :string
  end
end
