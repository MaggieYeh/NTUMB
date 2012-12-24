class AddDeletedAtToCarouselTranslation < ActiveRecord::Migration
  def change
    add_column :carousel_translations, :deleted_at, :datetime
  end
end
