class AddPhoneOneAndPhoneTwoToHomePageConfig < ActiveRecord::Migration
  def change
    add_column :home_page_configs, :phone_one, :string
    add_column :home_page_configs, :phone_two, :string
  end
end
