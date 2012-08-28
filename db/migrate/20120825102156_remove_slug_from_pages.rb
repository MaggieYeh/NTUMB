class RemoveSlugFromPages < ActiveRecord::Migration
  def up
    remove_column :pages, :slug
  end

  def down
    add_column :pages, :slug, :string
  end
end
