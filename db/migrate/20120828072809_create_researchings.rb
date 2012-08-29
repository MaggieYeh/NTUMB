class CreateResearchings < ActiveRecord::Migration
  def change
    create_table :researchings do |t|
      t.integer :teacher_id
      t.integer :research_area_id

      t.timestamps
    end
  end
end
