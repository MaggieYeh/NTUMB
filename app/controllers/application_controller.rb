class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_locale
  before_filter :set_current_department


  # cancan
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to admin_dashboard_path, :alert => exception.message
  end

  def current_ability
    @current_ability ||= Ability.new(current_admin_user)
  end

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
