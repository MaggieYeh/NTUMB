class AddLinkUrlToCarouselTranslation < ActiveRecord::Migration
  def change
    add_column :carousel_translations, :link_url, :string
  end
end
