class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_locale
  before_filter :set_current_department

  #attr_reader :current_department

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
  private
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
  def set_current_department
    #@current_department = params[:department_name] || "management"
    Department.current_department = params[:department] || "management"
  end
end
