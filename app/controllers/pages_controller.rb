class PagesController < ApplicationController
  before_filter :find_pages
  before_filter :build_menu
  def view
    path = "/"+params[:path]
    @page = @pages.find_by_path(path) || not_found
  end

  def home
    @department = params[:department]
    render 'pages/home/management'
  end

private

  def build_menu
    @menu = @pages && create_menu(@pages)
  end
  
  def find_pages
    @pages = Page.send(Department.current_department)
  end

  def page_path_to(page)
    path = page.path
    path.prepend("/#{Department.current_department.to_s}") unless Department.current_department.downcase == "management"
    path.prepend("/#{I18n.locale.to_s}") unless I18n.locale == I18n.default_locale
    path
  end

  def create_menu(pages)
    menu = {}
    pages.roots.each do |p|
      menu[p.menu_title.intern] = { path: page_path_to(p), 
                                    children: p.children && create_child_menu(p.children) }
    end
    menu
  end
  def create_child_menu(pages)
    child_menu = {}
    pages.each do |p|
      child_menu[p.menu_title.intern] = { path: page_path_to(p), 
                                          children: p.children && create_child_menu(p.children) }
    end
    child_menu
  end
end
