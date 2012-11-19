class TranslateCarousel < ActiveRecord::Migration
  def up
    Carousel.create_translation_table!({
      :caption => :text,
      :title => :string
    }, {
      :migrate_data => true
    })
  end

  def down
    Carousel.drop_translation_table! :migrate_data => true
  end
end
