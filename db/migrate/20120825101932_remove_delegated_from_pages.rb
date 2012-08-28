class RemoveDelegatedFromPages < ActiveRecord::Migration
  def up
    remove_column :pages, :delegated
  end

  def down
    add_column :pages, :delegated, :bool
  end
end
