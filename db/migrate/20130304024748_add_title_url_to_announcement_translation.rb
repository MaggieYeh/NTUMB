class AddTitleUrlToAnnouncementTranslation < ActiveRecord::Migration
  def change
    add_column :announcement_translations, :title_url, :string
  end
end
