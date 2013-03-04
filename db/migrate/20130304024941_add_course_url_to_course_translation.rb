class AddCourseUrlToCourseTranslation < ActiveRecord::Migration
  def change
    add_column :course_translations, :course_url, :string
  end
end
