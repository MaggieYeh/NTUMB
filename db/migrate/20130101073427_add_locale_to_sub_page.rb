class AddLocaleToSubPage < ActiveRecord::Migration
  def change
    add_column :sub_pages, :locale, :string
  end
end
