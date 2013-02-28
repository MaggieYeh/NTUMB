class AddEngAddressToHomePageConfig < ActiveRecord::Migration
  def change
    add_column :home_page_configs, :eng_address, :string
  end
end
