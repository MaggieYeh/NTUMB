class AddAddressToHomePageConfig < ActiveRecord::Migration
  def change
    add_column :home_page_configs, :address, :string
  end
end
