class CreateNewwebTeacherPublications < ActiveRecord::Migration
  def change
    create_table :newweb_teacher_publications do |t|
      t.integer :teacher_id
      t.string :author
      t.string :year
      t.string :title
      t.string :journal_or_conference_orpublisher
      t.integer :type_id
      t.string :date
      t.string :location
      t.text :other

      t.timestamps
    end
  end
end
