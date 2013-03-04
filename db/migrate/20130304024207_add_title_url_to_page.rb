class AddTitleUrlToPage < ActiveRecord::Migration
  def change
    add_column :pages, :title_url, :string
  end
end
