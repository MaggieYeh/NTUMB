module ApplicationHelper
  def page_tree_selection(p = nil)
    nested_set_options(Page,p) do |i| 
      d = "-"
      "#{d*i.level} #{i.menu_title}"
    end
  end
end
