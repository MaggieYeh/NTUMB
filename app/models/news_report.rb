class NewsReport < ActiveRecord::Base
  attr_accessible :content, :title, :department_id
  belongs_to :department
end
