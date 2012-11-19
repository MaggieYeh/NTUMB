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
    @announcements = Announcement.send(@current_department_name).recent(8)
    @jobs_announcements = Announcement.send(@current_department_name).recent(20).jobs
    @student_announcements = Announcement.send(@current_department_name).recent(20).student
    @carousels = Carousel.send(@current_department_name).recent(6)
    @news_all = NewsReport.send(@current_department_name).recent(6)
    @news = @news_all[0..2] || []
    @news2 = @news_all[3..5] || []
    if Rails.cache.exist?('videos')
      @videos = Rails.cache.read('videos')
    else
      @videos = fetch_youtube_channel_list
      Rails.cache.write('videos', @videos, expires_in: 10.minutes)
    end
    #render 'pages/home/index'
  end

private

  def build_page_nav
    @nav_list = ::MyUtils.build_nav_list(@page)
  end

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
