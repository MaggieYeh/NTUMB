class NewsReport < ActiveRecord::Base
  attr_accessible :department_id
  belongs_to :department
  attr_accessible :translations_attributes, :content, :title
  attr_accessible :preview, :text_up, :preview_color, :preview_text
  has_attached_file :preview, styles: { thumb: "290x150#", small: "175x130#" }


  validates :department_id, presence: true

  before_validation :config_preview

  translates :title, :content, :fallbacks_for_empty_translations => true
  class Translation
    attr_accessible :locale, :title, :content
    validates :title, presence: true
    validates :content, presence: true
  end
  accepts_nested_attributes_for :translations

  scope :recent, proc{|n = 3| order("created_at DESC").limit(n)}

private

  def config_preview
    if self.preview_color == "random"
      self.preview_color = StickerColor.generate_stikcer_colors(1).first.first
    end
    if self.text_up.to_s.empty? 
      self.text_up = false
    end
    if self.preview_text.to_s.empty?
      self.preview_text = MyTruncator.preview_truncator(self.content)
    end
  end

end
