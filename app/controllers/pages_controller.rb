class PagesController < ApplicationController

  def view
    path = "/"+params[:path]
    @page = department_page_variable.find_by_path(path) || not_found
    if @page.delegated_as_controller_index?
      redirect_to :controller => @page.delegated_to.intern, :action => :index
    end
    build_page_nav
  end

  def home
    load_home_page_config
    prepare_tabs
    prepare_carousels
    prepare_news
  end

private

  def load_home_page_config
    @home_config = HomePageConfig.send(@current_department_name)
  end

  def prepare_carousels
    translated_carousels = Carousel.send(@current_department_name).all.select do |c|
      !c.translation_for(I18n.locale).title.empty?
    end
    @carousels = translated_carousels.select(&:ordering).sort_by(&:ordering) + \
                 translated_carousels.reject(&:ordering)
    @carousels = @carousels.take(6)
  end

  def prepare_tabs
    @tabs = @home_config.home_page_tab_fields
    @tab_contents = []
    @tabs.each do |tab|
      unless tab.is_youtube?
        content = []
        temp = []
        tab.announce_categories.each do |ann_c|
          temp += ann_c.announcements.select do |ann| 
                    ann.department == @current_department
                  end
        end # tab.announce_categories
          sticky = temp.select(&:sticky).select do |a|
            !(a.translation_for(I18n.locale).name.empty? || a.translation_for(I18n.locale).content.empty?)
          end.sort_by{|a| a.announce_date}.reverse
          non_sticky = temp.reject(&:sticky).select do |a|
            !(a.translation_for(I18n.locale).name.empty? || a.translation_for(I18n.locale).content.empty?)
          end.take(10).sort_by{|a| a.announce_date}.reverse
        content = sticky + non_sticky
        @tab_contents << content
      else
        videos = fetch_youtube_channel_list(tab.youtube_channel_account)
        @tab_contents << videos
      end # unless tab.is_youtube
    end # @tabs.each
  end

  def prepare_news
    @news_all = NewsReport.send(@current_department_name).recent(20).select do |n|
      !(n.translation_for(I18n.locale).title.empty? || n.translation_for(I18n.locale).content.empty?)
    end.take(6)
    @news = @news_all[0..2] || []
    @news2 = @news_all[3..5] || []
  end

  def build_page_nav
    @nav_list = ::MyUtils.build_nav_list(@page)
  end

  def fetch_youtube_channel_list(account)
    videos = []
    if Rails.cache.exist?("#{account}_videos")
      videos = Rails.cache.read("#{account}_videos")
    else
      doc = Nokogiri::XML(open("http://gdata.youtube.com/feeds/api/users/#{account}/uploads?v=2").read)
      doc.css("entry").each do |e|
        videos << parse_video(e)
      end
      Rails.cache.write("#{account}_videos", videos, expires_in: 10.minutes)
    end
    videos
  end

  def parse_video(video_entry)
    ret = {}
    ret["title"] = video_entry.css("title").text
    ret["video_url"] = video_entry.css("link[rel='alternate']").attr("href").value
    ret["thumb_url"] = video_entry.css("media|group media|thumbnail[yt|name='default']").attr('url').value
    duration = video_entry.css("media|group media|thumbnail[yt|name='default']").attr('time').value
    duration_h = duration[0..1].to_i
    duration_m = duration[3..4].to_i
    duration_s = duration[6..7].to_i
    ret["duration"] = ""
    ret["duration"] << "#{duration_h}:" unless duration_h == 0
    if (duration_h != 0) and (duration_m < 10)
      ret["duration"] << "0#{duration_m.to_s}:"
    else
      ret["duration"] << duration_m.to_s << ':'
    end
    if duration_s < 10
      ret["duration"] << "0#{duration_s.to_s}"
    else
      ret["duration"] << "#{duration_s.to_s}" 
    end
    ret["description"] = video_entry.css("media|group media|description").text[0..20]
    ret["published_at"] = Time.strptime(video_entry.css("published").text,'%Y-%m-%d').to_date.to_s
    #ret["view_count"] = video_entry.css("yt|statistics").attr('viewCount').value
    ret
  end

end
