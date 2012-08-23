class AddDepartmentIdToNewsReports < ActiveRecord::Migration
  def change
    add_column :news_reports, :department_id, :integer
  end
end
