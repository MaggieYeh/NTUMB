module MyUtils

  def build_nav_list(page)
    nav_root = nil
    if page.level == 0
      nav_root = page
    else
      nav_root = page.parent
    end
    count = 0
    leng = nav_root.children.count
    nav_list = nav_root.children.sort_by{|c| c.position}.map do |c|
      # below c.path should've been page_path_to(c) but I don't know why c.path have already
      # been the right one
      [c.translation_for(I18n.locale).menu_title,c.path] 
    end.unshift([nav_root.translation_for(I18n.locale).menu_title,page_path_to(nav_root)])
    nav_list
  end
  module_function :build_nav_list

  def page_path_to(page)
    path = page.path
    prepend_prefix_params_to_path(path)
  end
  module_function :page_path_to

  def prepend_prefix_params_to_path(path, prepend_department = true)
    if prepend_department && !(Department.current_department_name.downcase == "management")
      path.prepend("/#{Department.current_department_name.to_s}") 
    end
    path.prepend("/#{I18n.locale.to_s}") unless I18n.locale == I18n.default_locale
    path
  end
  module_function :prepend_prefix_params_to_path

end
