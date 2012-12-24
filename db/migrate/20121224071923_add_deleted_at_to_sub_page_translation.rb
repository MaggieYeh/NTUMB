class AddDeletedAtToSubPageTranslation < ActiveRecord::Migration
  def change
    add_column :sub_page_translations, :deleted_at, :datetime
  end
end
