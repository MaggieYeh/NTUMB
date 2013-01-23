class AnnounceFielding < ActiveRecord::Base
  attr_accessible :announce_category_id, :home_page_tab_field_id
  belongs_to :home_page_tab_field
  belongs_to :announce_category
end
