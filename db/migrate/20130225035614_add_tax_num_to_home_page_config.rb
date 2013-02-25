class AddTaxNumToHomePageConfig < ActiveRecord::Migration
  def change
    add_column :home_page_configs, :tax_num, :string
  end
end
