class AnnouncementsController < ApplicationController

  before_filter :build_nav_list

  def index
    @announcements = Announcement.send(@current_department_name).select do |a|
      !a.translation_for(I18n.locale).name.empty?
    end
  end

  def show
    @announcement = Announcement.find(params[:id])
  end

private

  def build_nav_list
    @nav_list = department_page_variable.nav_list_for("announcements")
  end

end
