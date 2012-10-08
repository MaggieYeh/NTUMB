class AddAttachmentPictureToCarousels < ActiveRecord::Migration
  def self.up
    change_table :carousels do |t|
      t.has_attached_file :picture
    end
  end

  def self.down
    drop_attached_file :carousels, :picture
  end
end
