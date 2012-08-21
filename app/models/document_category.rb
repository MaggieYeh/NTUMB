class DocumentCategory < ActiveRecord::Base
  attr_accessible :name
  has_many :documents, :inverse_of => :category
  def label_name
    I18n.t "#{name}.name"
  end
  def self.recent(num = 5)
    self.order("updated_at DESC").limit(num)
  end
end
