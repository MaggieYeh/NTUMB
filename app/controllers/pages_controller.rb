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
    #render 'pages/home/index'
  end

end
