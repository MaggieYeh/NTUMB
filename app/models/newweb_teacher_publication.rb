class NewwebTeacherPublication < ActiveRecord::Base
  attr_accessible :author, :date, :journal_or_conference_orpublisher, :location, :other,
                  :teacher_id, :title, :publication_type_id, :year
  belongs_to :teacher
  belongs_to :publication_type
  scope :paper, lambda { where(publication_type_id: 1) }
  scope :conference, lambda { where(publication_type_id: 2) }
  scope :book, lambda { where(publication_type_id: 3) }
  scope :other, lambda { where(publication_type_id: 4) }
end
