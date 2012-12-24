class Carousel < ActiveRecord::Base
  attr_accessible :caption, :link_url, :title, :picture, :department_id, :ordering
  has_attached_file :picture, styles: { medium: "670x400#" }
  attr_accessible :translations_attributes
  acts_as_paranoid

  translates :caption, :link_url, :title, :fallbacks_for_empty_translations => true
  class Translation
    attr_accessible :locale, :title, :caption, :link_url
    acts_as_paranoid
    before_validation :check_link_url
  private
    def check_link_url
      unless self.link_url.to_s.empty?
        unless self.link_url.to_s.match(/^(http:\/\/|https:\/\/|ftp:\/\/)/)
          self.link_url.prepend("http://")
        end
      end
    end
  end
  accepts_nested_attributes_for :translations

  scope :recent, proc{|n = 3| order("created_at DESC").limit(n)}

  belongs_to :department
  before_validation :check_link_url

private

  def check_link_url
    unless self.link_url.to_s.empty?
      unless self.link_url.to_s.match(/^(http:\/\/|https:\/\/|ftp:\/\/)/)
        self.link_url.prepend("http://")
      end
    end
  end
  
end
::MyUtils.add_department_scopes(Carousel)
