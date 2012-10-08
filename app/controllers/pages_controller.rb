class PagesController < ApplicationController

  def view
    path = "/"+params[:path]
    @page = department_variable.find_by_path(path) || not_found
    if @page.delegated?
      redirect_to :controller => @page.delegated_to.intern, :action => :index
    end
  end

  def home
    @announcements = Announcement.send(@current_department_name)
    @carousels = Carousel.recent
    #render 'pages/home/index'
  end

end
