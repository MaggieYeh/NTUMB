class Document < ActiveRecord::Base
  attr_accessible :document_category_id, :document_file, :department_id, :discription, :announcement_id
  belongs_to :document_category
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

  def publish_date
    self.updated_at.to_date
  end

end
Department::DEPARTMENTS.each do |department_name|
  Document.instance_eval %Q{
    def #{department_name}
      Department.find_by_name("#{department_name}").documents
    end
    def #{department_name.downcase}
      Department.find_by_name("#{department_name}").documents
    end
    def #{department_name.upcase}
      Department.find_by_name("#{department_name}").documents
    end
  }
end
