class FixCarouselColumnName < ActiveRecord::Migration
  def change
    rename_column :carousels, :order, :ordering
  end
end
