class AddYoutubeChannelAccountToHomePageTabField < ActiveRecord::Migration
  def change
    add_column :home_page_tab_fields, :youtube_channel_account, :string
  end
end
