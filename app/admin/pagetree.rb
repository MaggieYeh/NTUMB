ActiveAdmin.register Page do

  collection_action :sort, :method => :post do
    params[:page].each_with_index do |p,i|
      #binding.pry
      Page.update_all({position: i+1, parent_id: p.second.to_i != 0 ? p.second.to_i : nil},
      {id: p.first})
    end
    render :nothing => true
  end

  index :as => :tree do |page|
    if page.parent == nil
      li :for => page, :class => "sortable_item" do
        div do
          span "[handle]", :class => "handle"
          span page.menu_title
          div :class => "item_actions" do
            span do
              link_to "edit", "pages/#{page.id}/edit"
            end
          end
        end
        eval child_tree(page,"page")
      end
    end
  end

  form do |f|                         
    f.inputs "Page" do
      f.input :title
      f.input :menu_title
      f.input :content
      f.input :delegated
      f.input :parent_id, as: :select, collection: page_tree_selection(f.object)
    end
    f.buttons                         
  end 

  filter :title
  filter :menu_title
  filter :content
  filter :delegate
  filter :delegate
  filter :updated_at

end
