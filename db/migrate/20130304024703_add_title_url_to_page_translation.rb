class AddTitleUrlToPageTranslation < ActiveRecord::Migration
  def change
    add_column :page_translations, :title_url, :string
  end
end
