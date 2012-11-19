#!/bin/env ruby
# encoding: utf-8
Page.descendants.each_with_index do |dpage,i|
  ActiveAdmin.register dpage do

    config.batch_actions = false
    config.paginate = false
    if dpage == ManagementPage
      menu parent: "內容頁面", priority: 0,if: proc{ can?(:manage,dpage) }
    else
      menu parent: "內容頁面",if: proc{ can?(:manage,dpage) }
    end
    d_page = dpage.name.underscore
    d_pages = dpage.name.underscore.pluralize

    controller.authorize_resource

    controller do
      def create
        create! do |format|
          format.html { redirect_to "/admin/#{controller_name}" }
        end
      end
    end

    collection_action :sort, :method => :post do
      params[d_page.intern].each_with_index do |p,i|
        dpage.update_all( {position: i+1, parent_id: p.second.to_i != 0 ? p.second.to_i : nil},
        {id: p.first})
      end
      # in order to trigger before_save callbacks
      dpage.rebuild!
      render :nothing => true
    end

    form do |f|                         
      f.inputs "#{d_page}" do
        f.input :url_name
        f.input :delegated_to, label: "外部連結", 
                hint: "如果有外部連結，則會直接連到你所輸入的網址，內文不會出現"
        f.input :parent_id, as: :select,
                 collection: page_tree_selection(f.object,dpage), 
                 selected: f.object.parent_id || params[:parent_id]
      end
      f.globalize_inputs :translations do |gf|
        gf.inputs do
          gf.input :title
          gf.input :menu_title
          gf.input :content, as: :ckeditor, input_html: { height: 500 }
          gf.input :locale, as: :hidden
        end
      end
      f.actions                         
    end 

    filter :title
    filter :menu_title
    filter :content
    filter :delegate
    #filter :updated_at

    index ({ :as => :tree, :download_links => false, 
             :"data-update-url" => "/admin/#{d_pages}/sort"
           }) do |page|
      if page.parent == nil
        li :for => page, :class => "sortable_item" do
          div do
            span "[handle]", :class => "handle"
            span page.menu_title
            div :class => "tree_item_actions" do
              page_path = d_pages+"/"+page.id.to_s 
              pages_path = d_pages
              
              unless page.delegated_as_controller_index?
                span do
                  link_to I18n.t("active_admin.edit"),"/admin/#{page_path}/edit"
                end
                span do
                  link_to I18n.t("active_admin.view"), "/admin/#{page_path}/"
                end
                span do
                  link_to I18n.t("active_admin.new_child_page"), 
                          "#{pages_path}/new?parent_id=#{page.id}"
                end
                span do
                  link_to I18n.t("active_admin.delete"),"/admin/#{page_path}", method: :delete, data: {confirm: I18n.t("active_admin.delete_confirmation") }
                end
              end
            end
          end
          child_tree(self,page,d_pages)
        end
      end
    end #index

  end
end
