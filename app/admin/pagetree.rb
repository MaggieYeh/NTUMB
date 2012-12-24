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
      def update
        update! do |format|
          format.html { redirect_to "/admin/#{controller_name}" }
        end
      end
      def create
        create! do |format|
          format.html { redirect_to "/admin/#{controller_name}" }
        end
      end
    end

    collection_action :sort, :method => :post do
      neworder = JSON.parse(params[:neworder])
      dpage.sort_new_position(neworder)
      #params[d_page.intern].each_with_index do |p,i|
        #dpage.update_all( {position: i+1, parent_id: p.second.to_i != 0 ? p.second.to_i : nil},
        #{id: p.first})
      #end
      # in order to trigger before_save callbacks
      #raise "#{dpage} can't not be rebuilt!" unless dpage.rebuild!
      render :nothing => true
    end

    form do |f|                         
      f.inputs "#{d_page}" do
        f.input :url_name
        f.input :delegated_to, label: "外部連結", 
                hint: "如果有外部連結，則會直接連到你所輸入的網址，內文不會出現"
        #f.input :parent_id, as: :select,
                 #collection: page_tree_selection(f.object,dpage), 
                 #selected: f.object.parent_id || params[:parent_id]
        f.input :parent_id, as: :hidden,
                :input_html => { :value => f.object.parent_id || params[:parent_id] }
      end
      f.globalize_inputs :translations do |gf|
        gf.inputs "段落一"do
          gf.input :menu_title, label: "選單名稱",
                   hint: "若將該語言的選單名稱留空白，則此頁面就不會在該語言出現"
          gf.input :title, label: "頁面標題"
          gf.input :content, label: "內容", as: :ckeditor, input_html: { height: 500 }
          gf.input :locale, as: :hidden
        end
      end
      f.inputs "新增頁面段落" do
        f.has_many :page_parts, {as: "頁面段落"} do |part|
          part.globalize_inputs :translations do |t|
            t.inputs "新段落" do
              t.input :title
              t.input :content, as: :ckeditor
              t.input :locale, as: :hidden
            end
          end
        end
      end
      f.inputs "新增延伸子頁面（將會以條列的形式列在頁面內容之後）" do
        f.has_many :sub_page_sections, {as: "子頁面群"}do |sub_sec|
          sub_sec.globalize_inputs :translations do |t|
            t.inputs "子頁面分組" do
              t.input :section_title, label: "組名"
              t.input :locale, as: :hidden
            end
          end # sub_sec.globalize_inputs
          sub_sec.has_many :sub_pages, {as: "子頁面"} do |sub_p|
            sub_p.globalize_inputs :translations do |t|
              t.inputs "子頁面內容" do
                t.input :title, label: "標題"
                t.input :content, label: "內容", as: :ckeditor, input_html: { height: 500 }
                t.input :locale, as: :hidden
              end
            end
            if sub_p.object.id
              sub_p.input :_destroy, :as => :boolean, :label => "delete"
            end
            sub_p.form_buffers.last # to avoid bug with nil possibly being returned from the above
          end # sub_sec.has_many :sub_pages
          if sub_sec.object.id
            sub_sec.input :_destroy, :as => :boolean, :label => "delete"
          end
          sub_sec.form_buffers.last # to avoid bug with nil possibly being returned from the above
        end # f.has_many section
      end
      f.inputs "新增附件（非必要）" do
        f.has_many :documents do |d|
          d.input :discription, input_html: { rows: 5 }
          d.input :document_file
          d.input :document_category
          d.input :department,
                  :member_label => Proc.new {|d| " "+I18n.t("scopes.#{d.name}")}
          if d.object.id
            d.input :_destroy, :as => :boolean, :label => "delete"
          end
          d.form_buffers.last # to avoid bug with nil possibly being returned from the above
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
