class PagesController < ApplicationController
  def view
    #dname = params[:path].split("/").first
    #if Department.pluck("name").map{|name| name.downcase}.include?(dname.downcase)
    ##if Page.methods.include?(dname.intern)
      #path = params[:path].gsub(/\/.*/).first
      #@dname = "/" + dname
      #pages = Page.send(dname)
    #else
      #path = "/"+params[:path]
      #@dname = ""
      #pages = Page.Management
    #end
      #if params[:dname] && Page.methods.include?(params[:dname].intern)
        #pages = Page.send(params[:dname])
        #@dname = "/#{params[:dname]}"
      #else
        #pages = Page.Management
        #@dname = ""
      #end
    #binding.pry
    #@page = pages.find_by_path("/#{params[:path]}") || not_found
    pages = Page.send(Department.current_department)
    path = "/"+params[:path]
    @page = pages.find_by_path(path) || not_found
    @menu = pages && create_menu(pages)
  end

private

  def page_path_to(page)
    #page_path(page.path[1..-1])
    path = page.path
    path.prepend("/#{Department.current_department.to_s}") unless Department.current_department.downcase == "management"
    path.prepend("/#{I18n.locale.to_s}") unless I18n.locale == I18n.default_locale
    path
  end

  def create_menu(pages)
    menu = {}
    pages.roots.each do |p|
      #binding.pry
      #menu[p.menu_title.intern] = { path: p.path, 
      #menu[p.menu_title.intern] = { path: page_path(p), 
      menu[p.menu_title.intern] = { path: page_path_to(p), 
                                    children: p.children && create_child_menu(p.children) }
    end
    menu
  end
  def create_child_menu(pages)
    child_menu = {}
    pages.each do |p|
      #child_menu[p.menu_title.intern] = { path: p.path, 
      child_menu[p.menu_title.intern] = { path: page_path_to(p), 
                                          children: p.children && create_child_menu(p.children) }
    end
    child_menu
  end
end
