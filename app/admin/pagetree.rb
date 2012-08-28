#!/bin/env ruby
# encoding: utf-8
# Solution!
# PageClassName as a constant which stores all xxxPage class name
# and then call PageClassName.each do |pcn|
#   ActiveAdmin.register instance_variable_get(pcn) do
#     the same
#   end
# end
#
#xxxxxxxxx  WRONG! xxxxxxxxxx
# Now I use DepartmentPage module which will have all subclass department pages
# And I can do DepartmentPage.constants => array to get all those new
# And I can use DepartmentPage.const_get to call it
# Example: DepartmentPage.constants.each do |dpage|
#   DepartmentPage.const_get(dpage) # This line will call DepartmentPage::#{dpage}
# end
#

Page.descendants.each do |dpage|
  ActiveAdmin.register dpage do
    config.batch_actions = false
    menu :parent => "內容頁面"
    d_page = dpage.class_name.underscore
    d_pages = dpage.class_name.underscore.pluralize

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
        f.input :title
        f.input :menu_title
        f.input :url_name
        f.input :content, :as => :ckeditor #:input_html => { :class => "ckeditor" }
        f.input :parent_id, as: :select,
                 collection: page_tree_selection(f.object,dpage), 
                 selected: f.object.parent_id || params[:parent_id]
      end
      f.buttons                         
    end 

    filter :title
    filter :menu_title
    filter :content
    filter :delegate
    filter :updated_at

    index ({ :as => :tree, :download_links => false, 
             :"data-update-url" => "/admin/#{d_pages}/sort"
           }) do |page|
             #title: I18n.t("scopes.#{dname}") + "頁面"}) do |page|
      if page.parent == nil
        li :for => page, :class => "sortable_item" do
          div do
            span "[handle]", :class => "handle"
            span page.menu_title
            div :class => "item_actions" do
              page_path = d_pages+"/"+page.id.to_s 
              pages_path = d_pages
              
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
              unless page.delegated?
                span do
                  link_to I18n.t("active_admin.delete"),"/admin/#{page_path}", method: :delete, data: {confirm: I18n.t("active_admin.delete_confirmation") }
                end
              end
            end
          end
          child_tree2(self,page,d_pages)
        end
      end
    end #index

  end
end

#Department.pluck("name").each_with_index do |dname,index|
  #ActiveAdmin.register Page.send(dname), :as => dname + "_page" do
    #menu :parent => "內容頁面", :priority => index+1, 
         #:label => proc { I18n.t("active_admin.scopes.#{dname}") }

    ##self.send(:scope, dname, {:default => true})

    #controller do
      #eval %Q{
        #def scoped_collection
          #end_of_association_chain.#{dname}
        #end
      #}
      #def create
        #instance_variable_set(
          #"@#{self.controller_name.singularize}", 
          ##[0..-7 is to delete xxx_pages's _pages
          #Page.send(controller_name[0..-7]).new(params[controller_name[0..-2]])
        #)
        #create! do |format|
          #format.html { redirect_to "/admin/#{controller_name}" }
        #end
      #end
      ##def index
        ##redirect_to "/admin" unless can? :manage,
      ##end
    #end

    #collection_action :sort, :method => :post do
      #params[:page].each_with_index do |p,i|
        #Page.update_all({position: i+1, parent_id: p.second.to_i != 0 ? p.second.to_i : nil},
        #{id: p.first})
      #end
      ## in order to trigger before_save callbacks
      #Page.send(dname).rebuild!
      #render :nothing => true
    #end


    #index ({ :as => :tree, :download_links => false, 
             #:"data-update-url" => "/admin/#{dname.downcase}_pages/sort",
             #title: I18n.t("scopes.#{dname}") + "頁面"}) do |page|
      #if page.parent == nil
        #li :for => page, :class => "sortable_item" do
          #div do
            #span "[handle]", :class => "handle"
            #span page.menu_title
            #div :class => "item_actions" do
              #page_path = (page.department.name+"Page").underscore.pluralize+"/"+page.id.to_s 
              #pages_path = (page.department.name+"Page").underscore.pluralize 
              #span do
                #link_to I18n.t("active_admin.edit"),"/admin/#{page_path}/edit"
              #end
              #span do
                #link_to I18n.t("active_admin.view"), "/admin/#{page_path}/"
              #end
              #span do
                #link_to I18n.t("active_admin.new_child_page"), 
                        #"#{pages_path}/new?parent_id=#{page.id}"
              #end
              #unless page.delegated
                #span do
                  #link_to I18n.t("active_admin.delete"),"/admin/#{page_path}", method: :delete, data: {confirm: I18n.t("active_admin.delete_confirmation") }
                #end
              #end
            #end
          #end
          #child_tree2(self,page)
        #end
      #end
    #end

    #form do |f|                         
      #f.inputs "#{dname} Page" do
        #f.input :title
        #f.input :menu_title
        #f.input :content, :as => :ckeditor #:input_html => { :class => "ckeditor" }
        ##f.input :delegated
        #f.input :parent_id, as: :select, collection: page_tree_selection(f.object,dname), 
                 #selected: f.object.parent_id || params[:parent_id]
      #end
      #f.buttons                         
    #end 

    #filter :title
    #filter :menu_title
    #filter :content
    #filter :delegate
    #filter :updated_at
    
  #end
#end
