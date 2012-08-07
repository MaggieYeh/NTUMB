class Department < ActiveRecord::Base
  attr_accessible :name, :page_ids
  has_many :pages
end
