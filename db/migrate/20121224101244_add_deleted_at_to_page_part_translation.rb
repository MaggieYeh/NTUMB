class AddDeletedAtToPagePartTranslation < ActiveRecord::Migration
  def change
    add_column :page_part_translations, :deleted_at, :datetime
  end
end
