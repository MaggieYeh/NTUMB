class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter do
    set_locale if request.path.match(/^\/admin/).nil?
  end
  before_filter do 
    set_current_department if request.path.match(/^\/admin/).nil?
  end
  before_filter do
    find_department_name if request.path.match(/^\/admin/).nil?
  end
  before_filter do
    build_header if request.path.match(/^\/admin/).nil?
  end
  before_filter do
    build_menu if request.path.match(/^\/admin/).nil?
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to admin_dashboard_path, :alert => exception.message
  end

  def current_ability
    @current_ability ||= Ability.new(current_admin_user)
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

private

  def build_header
    @header_text = I18n.t("front_end.#{@current_department_name}")
    @header_text.prepend(I18n.t('front_end.ntu') + " ")
    @header_link = @current_department_name.match(/management/i) ? @management_link : @current_department_link
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def set_current_department
    Department.current_department_name = params[:department] || "management"
  end

  def find_department_name
    @current_department_name = Department.current_department_name
    @department_names = Department.pluck("name")
  end

  def build_menu
    @menu = create_menu(department_variable)
    @management_link = prepend_prefix_params_to_path("/",false)
    @all_departments_links = @department_names.map do |d| 
      prepend_prefix_params_to_path("/#{d}",false)
    end
    @current_department_link = prepend_prefix_params_to_path("/#{@current_department_name}",false)
  end

  def department_variable
    Department.current_department_name.downcase.concat("_page").camelcase.constantize
  end

  def page_path_to(page)
    path = page.path
    prepend_prefix_params_to_path(path)
  end

  def prepend_prefix_params_to_path(path, prepend_department = true)
    if prepend_department && !(Department.current_department_name.downcase == "management")
      path.prepend("/#{Department.current_department_name.to_s}") 
    end
    path.prepend("/#{I18n.locale.to_s}") unless I18n.locale == I18n.default_locale
    path
  end

  def create_menu(d_const)
    menu = {}
    d_const.roots.sort_by{|p| p.position}.each do |p|
      menu[p.menu_title.intern] = { path: page_path_to(p), 
                                    children: p.children && create_child_menu(p.children) }
    end
    menu
  end

  def create_child_menu(pages)
    child_menu = {}
    pages.sort_by{|p| p.position}.each do |p|
      child_menu[p.menu_title.intern] = { path: page_path_to(p), 
                                          children: p.children && create_child_menu(p.children) }
    end
    child_menu
  end

end
