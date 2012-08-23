class Document < ActiveRecord::Base
  attr_accessible :category_id, :discription, :document_file, :department_id
  belongs_to :category, :class_name => "DocumentCategory"
  belongs_to :department
  #mount_uploader :document_file, DocumentFileUploader
  has_attached_file :document_file
  def self.recent(num = 5)
    self.order("updated_at DESC").limit(num)
  end
end
