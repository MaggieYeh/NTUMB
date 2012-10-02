module ActiveAdmin
  module Views
    class IndexAsTree < ActiveAdmin::Component
      #include Rails.application.routes.url_helpers
      def build(page_presenter, collection)
        add_class "tabbed_table"
        add_class "index"
        tabs = page_presenter.options[:tabs]
        #id = "#{collection.first.class.name}_tree" if collection
        collection.sort_by{|it| it.position}.each do |obj|
          instance_exec(obj, &page_presenter.block)
        end
      end
      def tag_name
        'div'
      end
    end
  end
end
