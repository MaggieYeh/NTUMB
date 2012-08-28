class AddDelegatedToToPages < ActiveRecord::Migration
  def change
    add_column :pages, :delegated_to, :string
  end
end
