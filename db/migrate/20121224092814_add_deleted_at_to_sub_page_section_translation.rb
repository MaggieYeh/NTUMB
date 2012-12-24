class AddDeletedAtToSubPageSectionTranslation < ActiveRecord::Migration
  def change
    add_column :sub_page_section_translations, :deleted_at, :datetime
  end
end
