class AnnounceCategory < ActiveRecord::Base
  attr_accessible :name
  has_many :announcements
  def label_name
    I18n.t "ann_category.#{name}.name"
  end
  CATEGORIES = %w[administrative events intern_opportunities scholarship_and_exchange_student news enrollments]
end
