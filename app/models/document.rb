class Document < ActiveRecord::Base
  attr_accessible :category_id, :discription, :document_file
  belongs_to :category, :class_name => "DocumentCategory"
  mount_uploader :document_file, DocumentFileUploader
  def self.recent(num = 5)
    self.order("updated_at DESC").limit(num)
  end
end
