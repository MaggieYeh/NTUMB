class AnnouncementsController < ApplicationController

  before_filter :build_nav_list

  def index
    if @current_department_name.downcase == "management"
      @announcements = Announcement.send(@current_department_name).select do |a|
        !a.translation_for(I18n.locale).name.empty?
      end
      all_deps = Department::DEPARTMENTS.clone
      all_deps.shift
      temp = []
      all_deps.each do |dep|
        temp += Announcement.send(dep).select do |a|
          a.picked_by_management && !a.translation_for(I18n.locale).name.empty?
        end
      end
      @announcements += temp
    else
      @announcements = Announcement.send(@current_department_name).select do |a|
        !a.translation_for(I18n.locale).name.empty?
      end
    end
    @announcements = @announcements.sort_by{|a| a.announce_date}.reverse
  end

  def show
    @announcement = Announcement.find(params[:id])
  end

private

  def build_nav_list
    @nav_list = department_page_variable.nav_list_for("announcements")
  end

end
