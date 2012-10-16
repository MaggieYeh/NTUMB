module ApplicationHelper
  def page_tree_selection(p, klass)
    nested_set_options( klass , p ) do |i| 
      d = "-"
      "#{d*i.level} #{i.menu_title}"
    end
  end
  #def page_tree_selection(p = nil, scope = nil)
    #nested_set_options( scope.nil? ? Page : Page.send(scope) , p ) do |i| 
      #d = "-"
      #"#{d*i.level} #{i.menu_title}"
    #end
  #end
  def relax_sanitize(input)
    Sanitize.clean(input, Sanitize::Config::RELAXED)
  end

  def my_html_truncator(input_string = "")
    input_string_without_img = remove_img(input_string)
    HTML_Truncator.truncate(input_string_without_img, 100, :length_in_chars => true)
  end

  def remove_img(string = "")
    string.gsub(/< *img[^>]*>/,"")
  end

end
