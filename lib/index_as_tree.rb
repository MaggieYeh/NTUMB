module ActiveAdmin
  module Views
    class IndexAsTree < ActiveAdmin::Component
      #include Rails.application.routes.url_helpers
      def build(page_presenter, collection)
        add_class "nested_sortable"
        add_class "index"
        if page_presenter.options[:"data-update-url"]
          set_attribute "data-update-url", page_presenter.options[:"data-update-url"]
        end
        #id = "#{collection.first.class.name}_tree" if collection
        collection.sort_by{|it| it.position}.each do |obj|
          instance_exec(obj, &page_presenter.block)
        end
      end
      def tag_name
        'ol'
      end
      def child_tree2(context,item,tree_index_path)
        if item.children
          context.instance_exec(context,item) do |context,current_node|
            ol do
              current_node.children.sort_by{|it| it.position}.each do |child|
                li :for => child, :class => 'sortable_item' do
                  div do
                    span '[handle]', :class => 'handle'
                    span child.menu_title
                    div :class => 'item_actions' do
                      #page_path= d_pages+"/" + child.id.to_s 
                      #pages_path= d_pages 
                      tree_node_path = tree_index_path + "/" + child.id.to_s
                      span do
                        link_to I18n.t("active_admin.edit"),"/admin/#{tree_node_path}/edit"
                      end
                      span do
                        link_to I18n.t("active_admin.view"),"/admin/#{tree_node_path}"
                      end
                      span do
                        link_to I18n.t("active_admin.new_child_page"),
                                "/admin/#{tree_index_path}/new?parent_id=#{child.id}"
                      end
                      unless child.delegated?
                        span do
                          link_to I18n.t("active_admin.delete"),"/admin/#{tree_node_path}", method: :delete, data: {confirm: I18n.t("active_admin.delete_confirmation") }
                        end
                      end
                    end
                  end
                  child_tree2(context,child,tree_index_path)
                end
              end
            end
          end
        end
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
