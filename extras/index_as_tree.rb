module ActiveAdmin
  module Views
    class IndexAsTree < ActiveAdmin::Component
      def build(page_presenter, collection)
        add_class "nested_sortable"
        add_class "index"
        #binding.pry
        #id = "#{collection.first.class.name}_tree" if collection
        collection.sort_by{|it| it.position}.each do |obj|
          instance_exec(obj, &page_presenter.block)
        end
      end
      def tag_name
        'ol'
      end
      def child_tree(item,itemVaribleName)
        if item.children
          evalstr = "
          ol do
            #{itemVaribleName}.children.sort_by{|it| it.position}.each do |child|
              li :for => child, :class => 'sortable_item' do
                div do
                  span '[handle]', :class => 'handle'
                  span child.menu_title
                  div :class => 'item_actions' do
                    span do
                      link_to 'edit', 'pages/' + child.id.to_s + '/edit'
                    end
                  end
                end
                eval child_tree(child,'child')
              end
            end
          end
          "
          #eval(evalstr)
        end
      end
    end
  end
end
