class Document < ActiveRecord::Base
  attr_accessible :category_id, :document_file, :department_id, :discription
  belongs_to :category, :class_name => "DocumentCategory"
  belongs_to :department
  has_attached_file :document_file

  attr_accessible :translations_attributes
  translates :discription, :fallbacks_for_empty_translations => true
  class Translation
    attr_accessible :locale, :discription
  end
  accepts_nested_attributes_for :translations

  def self.recent(num = 5)
    self.order("updated_at DESC").limit(num)
  end

end
