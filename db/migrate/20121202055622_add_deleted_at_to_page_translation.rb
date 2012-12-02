class AddDeletedAtToPageTranslation < ActiveRecord::Migration
  def change
    add_column :page_translations, :deleted_at, :datetime
  end
end
