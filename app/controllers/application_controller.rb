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
    build_links if request.path.match(/^\/admin/).nil?
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
    #@header_text.prepend(I18n.t('front_end.ntu') + " ") unless I18n.locale == :en
    @header_school_prefix = I18n.t("front_end.ntu")
    @header_link = @current_department_name.match(/management/i) ? @management_link : @current_department_link
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def set_current_department
    if params[:department].to_s.empty?
      Department.current_department_name = "management"
    else
      Department.current_department_name = params[:department]
    end
  end

  def find_department_name
    @current_department_name = Department.current_department_name
    @department_names = Department::DEPARTMENTS
    all_departments = Department::DEPARTMENTS.clone
    all_departments << Department::INTERNATIONAL_AFFAIRS
    @current_department = Department.find_by_name(all_departments.select{|d| 
                                              d.casecmp(@current_department_name) == 0}[0])
    @contact_info = @current_department.home_page_config.contact_info
    @phone_one = @current_department.home_page_config.phone_one 
    @phone_one = "+886-2-33661000" if @phone_one.to_s.empty?
    @phone_two = @current_department.home_page_config.phone_two
    @phone_two = "+886-2-33661008" if @phone_two.to_s.empty?
    @tax_num = @current_department.home_page_config.tax_num
    @tax_num = "+886-2-23632082" if @tax_num.to_s.empty?
    if I18n.locale == "en" || I18n.locale == :en
      @address = @current_department.home_page_config.eng_address
    else
      @address = @current_department.home_page_config.address
    end
    @address = I18n.t("front_end.address") if @address.to_s.empty?
  end

  def build_links
    @management_link = ::MyUtils.prepend_prefix_params_to_path("/",false)
    @all_departments_links = @department_names.map do |d| 
      ::MyUtils.prepend_prefix_params_to_path("/#{d}",false)
    end
    @current_department_link = ::MyUtils.prepend_prefix_params_to_path("/#{@current_department_name}",false)
  end

  def build_menu
    @menu = create_menu(department_page_variable)
  end

  def department_page_variable
    Department.current_department_name.downcase.concat("_page").camelcase.constantize
  end

        #menu[p.menu_title.intern] = { ::MyUtils.page_path_to(p), 
  def create_menu(d_const)
    menu = {}
    #d_const.roots.sort_by{|p| p.position}.each do |p|
    d_const.roots.sort_by{|p| p.lft}.each do |p|
      unless p.translation_for(I18n.locale).menu_title.to_s.empty? || p.url_name == "documents"
        menu[p.menu_title.intern] = { 
          path: (p.delegated? and !p.delegated_as_controller_index?) ? p.delegated_to : ::MyUtils.page_path_to(p),
          children: p.children && create_child_menu(p.children) }
      end
    end
    if @current_department_name == "management"
      menu["International Affairs"] = { path: "/en/ia", children: "" }
    end
    menu
  end

  def create_child_menu(pages)
    child_menu = {}
    #pages.sort_by{|p| p.position}.each do |p|
    pages.sort_by{|p| p.lft}.each do |p|
      unless p.translation_for(I18n.locale).menu_title.to_s.empty? || p.url_name == "documents"
        child_menu[p.menu_title.intern] = { 
          path: (p.delegated? and !p.delegated_as_controller_index?) ? p.delegated_to : ::MyUtils.page_path_to(p), 
          children: p.children && create_child_menu(p.children) }
      end
    end
    child_menu
  end

  def url_with_protocol(url)
    if url.to_s.empty? || url.to_s.blank?
      ""
    else
      /^http/.match(url) ? url : "http://#{url}"
    end
  end

end
