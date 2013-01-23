class AnnounceCategory < ActiveRecord::Base
  attr_accessible :name
  has_many :announcements
  has_many :announce_fieldings
  has_many :home_page_tab_fields, :through => :announce_fieldings
  def label_name
    I18n.t "ann_category.#{name}.name"
  end
  CATEGORIES = %w[administrative events intern_opportunities scholarship_and_exchange_student news enrollments]
end
