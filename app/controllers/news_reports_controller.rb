class NewsReportsController < ApplicationController

  before_filter :build_nav_list

  def index
    @news_reports = NewsReport.send(@current_department_name).select do |n|
      !n.translation_for(I18n.locale).title.empty?
    end
    @news_reports = @news_reports.sort_by{|n| n.announce_date}
  end

  def show
    @news_report = NewsReport.find(params[:id])
  end

private

  def build_nav_list
    @nav_list = department_page_variable.nav_list_for("news_reports")
  end

end
