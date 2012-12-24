class AddDeletedAtToCarousel < ActiveRecord::Migration
  def change
    add_column :carousels, :deleted_at, :datetime
  end
end
