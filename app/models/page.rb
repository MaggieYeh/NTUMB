class Page < ActiveRecord::Base
  attr_accessible :menu_title, :page_part_ids, :title, :content, :delegated, :position,
                  :department_id
# For acts_as_nested_set
  attr_accessible :parent_id
  attr_accessible :slug
  belongs_to :department

  acts_as_nested_set

  def delegated?
    self.delegated
  end

end
