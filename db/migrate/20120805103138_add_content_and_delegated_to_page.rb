class AddContentAndDelegatedToPage < ActiveRecord::Migration
  def change
    add_column :pages, :content, :text
    add_column :pages, :delegated, :boolean
  end
end
