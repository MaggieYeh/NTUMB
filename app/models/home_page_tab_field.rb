class HomePageTabField < ActiveRecord::Base
  attr_accessible :first_name, :home_page_config_id, :last_name, :visible, :announce_category_ids,
                  :youtube_channel_account

  belongs_to :home_page_config
  has_many :announce_fieldings
  has_many :announce_categories, :through => :announce_fieldings
  acts_as_paranoid

  attr_accessible :translations_attributes
  translates :first_name, :last_name
  class Translation
    attr_accessible :locale, :first_name, :last_name
  end
  accepts_nested_attributes_for :translations

  def is_youtube?
    !self.youtube_channel_account.to_s.empty?
  end

end
