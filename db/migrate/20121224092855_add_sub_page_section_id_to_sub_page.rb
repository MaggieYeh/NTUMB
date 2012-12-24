class AddSubPageSectionIdToSubPage < ActiveRecord::Migration
  def change
    add_column :sub_pages, :sub_page_section_id, :integer
  end
end
