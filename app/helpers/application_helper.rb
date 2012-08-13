module ApplicationHelper
  def page_tree_selection(p = nil, scope = nil)
    #binding.pry
    nested_set_options( scope.nil? ? Page : Page.send(scope) , p ) do |i| 
      d = "-"
      "#{d*i.level} #{i.menu_title}"
    end
  end
  def relax_sanitize(input)
    Sanitize.clean(input, Sanitize::Config::RELAXED)
  end
end
