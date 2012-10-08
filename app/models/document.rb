class Document < ActiveRecord::Base
  attr_accessible :category_id, :document_file, :department_id, :discription
  belongs_to :category, :class_name => "DocumentCategory"
  belongs_to :department
  belongs_to :announcement
  has_attached_file :document_file

  validates_attachment :document_file, presence: true

  attr_accessible :translations_attributes
  translates :discription, :fallbacks_for_empty_translations => true
  class Translation
    attr_accessible :locale, :discription
  end
  accepts_nested_attributes_for :translations

  scope :recent, proc{|n = 3| order("created_at DESC").limit(n)}

end
