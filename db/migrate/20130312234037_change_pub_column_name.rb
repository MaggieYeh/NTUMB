class ChangePubColumnName < ActiveRecord::Migration
  def up
    rename_column :newweb_teacher_publications, :type_id, :publication_type_id
  end

  def down
    rename_column :newweb_teacher_publications, :publication_type_id, :type_id
  end
end
