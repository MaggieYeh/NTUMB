class PagesController < ApplicationController

  def view
    path = "/"+params[:path]
    @page = department_variable.find_by_path(path) || not_found
    if @page.level == 0
      @nav_list = @page.children.map{|c|[c.translation_for(I18n.locale).menu_title,c.path]}.unshift([@page.translation_for(I18n.locale).menu_title,@page.path])
    else
      @nav_list = @page.parent.children.map{|c|[c.translation_for(I18n.locale).menu_title,c.path]}.unshift([@page.parent.translation_for(I18n.locale).menu_title,@page.parent.path])
    end
    if @page.delegated?
      redirect_to :controller => @page.delegated_to.intern, :action => :index
    end
  end

  def home
    @announcements = Announcement.send(@current_department_name)
    @carousels = Carousel.recent
    @news = NewsReport.recent(6)[0..2]
    @news2 = NewsReport.recent(6)[3..5]
    if Rails.cache.exist?('videos')
      @videos = Rails.cache.read('videos')
    else
      @videos = fetch_youtube_channel_list
      Rails.cache.write('videos', @videos, expires_in: 10.minutes)
    end
    #render 'pages/home/index'
  end

private

  def fetch_youtube_channel_list
    doc = Nokogiri::XML(open("http://gdata.youtube.com/feeds/api/users/NTUManagement/uploads?v=2").read)
    ret = []
    doc.css("entry").each do |e|
      ret << parse_video(e)
    end
    ret
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
    ret["view_count"] = video_entry.css("yt|statistics").attr('viewCount').value
    ret
  end

end
