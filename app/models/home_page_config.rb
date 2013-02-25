class HomePageConfig < ActiveRecord::Base
  attr_accessible :contact_info, :phone_one, :phone_two, :tax_num

  has_many :home_page_tab_fields, dependent: :destroy
  attr_accessible :home_page_tab_fields_attributes
  accepts_nested_attributes_for :home_page_tab_fields
  belongs_to :department
end
::MyUtils.add_department_scopes(HomePageConfig, false)
