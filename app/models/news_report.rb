class NewsReport < ActiveRecord::Base
  acts_as_paranoid
  attr_accessible :department_id, :announce_date
  belongs_to :department
  attr_accessible :translations_attributes, :content, :title
  attr_accessible :preview, :text_up, :preview_color, :preview_text
  has_attached_file :preview, styles: { thumb: "290x150#", small: "175x130#" }

  attr_accessible :documents_attributes
  has_many :documents
  accepts_nested_attributes_for :documents, :reject_if => proc { |d| d[:document_file].blank?},
                                :allow_destroy => true

  validates :department_id, presence: true

  before_validation :config_preview

  translates :title, :content, :preview_text, :fallbacks_for_empty_translations => true
  class Translation
    attr_accessible :locale, :title, :content, :preview_text
    #validates :title, presence: true
    #validates :content, presence: true
  end
  accepts_nested_attributes_for :translations

  scope :recent, proc{|n = 3| order("announce_date DESC").limit(n)}

private

  def config_preview
    if self.preview_color == "random"
      self.preview_color = StickerColor.generate_stikcer_colors(1).first.first
    end
    if self.text_up.to_s.empty? 
      self.text_up = false
    end
    if self.translation_for(:"zh-TW").preview_text.to_s.empty?
      self.translation_for(:"zh-TW").preview_text = MyTruncator.preview_truncator(self.translation_for(:"zh-TW").content)
    end
    if self.translation_for(:en).preview_text.to_s.empty?
      self.translation_for(:en).preview_text = MyTruncator.preview_truncator(self.translation_for(:en).content)
    end
    self.translation_for(:"zh-TW").preview_text = self.translation_for(:"zh-TW").preview_text[0..70]
    self.translation_for(:en).preview_text = self.translation_for(:en).preview_text[0..140]
  end

end
::MyUtils.add_department_scopes(NewsReport)
#(Department::DEPARTMENTS + Department::INTERNATIONAL_AFFAIRS).each do |department_name|
  #NewsReport.instance_eval %Q{
    #def #{department_name}
      #Department.find_by_name("#{department_name}").news_reports
    #end
    #def #{department_name.downcase}
      #Department.find_by_name("#{department_name}").news_reports
    #end
    #def #{department_name.upcase}
      #Department.find_by_name("#{department_name}").news_reports
    #end
  #}
#end
