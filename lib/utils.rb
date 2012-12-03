module MyUtils
  #def build_nav_list(page)
    #nav_root = page.root
    ##if page.level == 0
      ##nav_root = page
    ##else
      ##nav_root = page.parent
      ##nav_root = page.root
    ##end
    #count = 0
    #leng = nav_root.children.count
    #nav_list = nav_root.children.sort_by{|c| c.position}.map do |c|
      ## below c.path should've been page_path_to(c) but I don't know why c.path have already
      ## been the right one
      #[c.translation_for(I18n.locale).menu_title, 
      #((c.delegated? and !c.delegated_as_controller_index?) ? c.delegated_to : ::MyUtils.page_path_to(c))]
        ##page_path_to(c)] 
    #end.unshift([nav_root.translation_for(I18n.locale).menu_title,"#"])
    ##end.unshift([nav_root.translation_for(I18n.locale).menu_title,page_path_to(nav_root)])
    #nav_list
  #end
  #

  def sub_nav(page,level,ret)
    if page.children.empty?
      unless page.translation_for(I18n.locale).menu_title.to_s.empty?
        ret.push([page.translation_for(I18n.locale).menu_title,
        ((page.delegated? and !page.delegated_as_controller_index?) ? page.delegated_to : ::MyUtils.page_path_to(page)),level])
      end
    else
      unless page.translation_for(I18n.locale).menu_title.to_s.empty?
        ret.push([page.translation_for(I18n.locale).menu_title,"#",level])
        page.children.sort_by{|c| c.position}.each do |pc|
          sub_nav(pc,level+1,ret)
        end
      end
    end
  end
  module_function :sub_nav

  def build_nav_list(page)
    nav_root = page
    until nav_root.parent.nil?
      nav_root = nav_root.parent
    end
    nav_list = []
    ::MyUtils.sub_nav(nav_root,0,nav_list)
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
      if path.match(/\/#{Department.current_department_name.to_s}\//).nil?
        path.prepend("/#{Department.current_department_name.to_s}") 
      end
    end
    unless I18n.locale == I18n.default_locale 
      if path.match(/\/#{I18n.locale}\//).nil?
        path.prepend("/#{I18n.locale.to_s}")
      end
    end
    path
  end
  module_function :prepend_prefix_params_to_path

  def add_department_scopes(model_constant)
    (Department::DEPARTMENTS + [Department::INTERNATIONAL_AFFAIRS]).each do |department_name|
      model_constant.instance_eval %Q{
        def #{department_name}
          Department.find_by_name("#{department_name}").#{model_constant.to_s.underscore}s
        end
        def #{department_name.downcase}
          Department.find_by_name("#{department_name}").#{model_constant.to_s.underscore}s
        end
        def #{department_name.upcase}
          Department.find_by_name("#{department_name}").#{model_constant.to_s.underscore}s
        end
      }
    end
  end
  module_function :add_department_scopes

end
