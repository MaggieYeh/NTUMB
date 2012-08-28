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
end
