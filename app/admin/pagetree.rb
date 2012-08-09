#!/bin/env ruby
# encoding: utf-8
#def register_all_scope(context)
  #context.instance_exec do
    #Department.pluck("name").unshift("all").reverse.each do |dname|
      #ActiveAdmin.register dname == "all" ? Page : Page.send(dname), :as => dname do
        #menu :parent => "Page"
        #self.send(:scope, dname, {:default => true})
      #end
    #end
  #end
#end
#Department.pluck("name").unshift("all").each_with_index do |dname,index|
  #ActiveAdmin.register dname == "all" ? Page : Page.send(dname), :as => dname + "-page" do

#include Rails.application.routes.url_helpers

Department.pluck("name").each_with_index do |dname,index|
  ActiveAdmin.register Page.send(dname), :as => dname + "-page" do
    menu :parent => "Page", :priority => index+1, 
         :label => proc { I18n.t("active_admin.scopes.#{dname}") }

    self.send(:scope, dname, {:default => true})

    controller do
      def create
        instance_variable_set("@#{self.controller_name.singularize}", 
            Page.send(controller_name[0..-7].capitalize).new(params[controller_name[0..-2]]))
        create! do |format|
          #format.html { redirect_to "admin/#{controller_name[0..-2]}/#{@page.id}" }
          format.html { redirect_to "/admin/#{controller_name}" }
        end
      end
    end

    collection_action :sort, :method => :post do
      params[:page].each_with_index do |p,i|
        Page.update_all({position: i+1, parent_id: p.second.to_i != 0 ? p.second.to_i : nil},
        {id: p.first})
      end
      # in order to trigger before_save callbacks
      Page.send(dname).each{|p| p.save}
      render :nothing => true
    end

    index ({ :as => :tree, :download_links => false, 
             :"data-update-url" => "/admin/#{dname.downcase}_pages/sort" }) do |page|
      if page.parent == nil
        li :for => page, :class => "sortable_item" do
          div do
            span "[handle]", :class => "handle"
            span page.menu_title
            div :class => "item_actions" do
              page_path = (page.department.name+"Page").underscore.pluralize+"/"+page.id.to_s 
              pages_path = (page.department.name+"Page").underscore.pluralize 
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
              #span do
              #link_to "edit", send("edit_admin_#{page.department.name.downcase}_page_path",page)
##"/admin/#{(page.department.name + page.class.name).underscore.pluralize}/#{page.id}/edit"
              #end
            end
          end
          child_tree2(self,page)
        end
      end
    end

    form do |f|                         
      f.inputs "#{dname} Page" do
        f.input :title
        f.input :menu_title
        f.input :content, :as => :ckeditor #:input_html => { :class => "ckeditor" }
        f.input :delegated
        f.input :parent_id, as: :select, collection: page_tree_selection(f.object,dname), 
                 selected: params[:parent_id]
        #f.input :dname, as: :hidden, :input_html => { value: "#{dname}" }
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
end
#Department.pluck("name").unshift("all").each do |department_name|
  #ActiveAdmin.register Page.send("#{department_name}"), :as => department_name do
    #menu :parent => "Page"
    #self.send(:scope, department_name, {:default => true})
  #end
#end

#ActiveAdmin.register Page do
  ##binding.pry
  ##scope :Management, :default => true
  ##scope :BA
  ##scope :Acc
  ##scope :Fin
  ##scope :IB
  ##scope :IM
  ##scope :EMBA
  ##scope :MBA
  ##following code will dynamicly generate above code
  #Department.all.each_with_index do |department,index|
    #self.send( :scope, department.name, { :default => index == 0 } ) 
  #end

  #collection_action :sort, :method => :post do
    #params[:page].each_with_index do |p,i|
      ##binding.pry
      #Page.update_all({position: i+1, parent_id: p.second.to_i != 0 ? p.second.to_i : nil},
      #{id: p.first})
    #end
    #render :nothing => true
  #end

  #index :as => :tree, :download_links => false do |page|
    #if page.parent == nil
      #li :for => page, :class => "sortable_item" do
        #div do
          #span "[handle]", :class => "handle"
          #span page.menu_title
          #div :class => "item_actions" do
            #span do
              #link_to "edit", "pages/#{page.id}/edit"
            #end
          #end
        #end
        ##eval child_tree(page,"page")
        #child_tree2(self,page)
      #end
    #end
  #end

  #form do |f|                         
    #f.inputs "Page" do
      #f.input :title
      #f.input :menu_title
      #f.input :content
      #f.input :delegated
      #f.input :parent_id, as: :select, collection: page_tree_selection(f.object)
    #end
    #f.buttons                         
  #end 

  #filter :title
  #filter :menu_title
  #filter :content
  #filter :delegate
  #filter :delegate
  #filter :updated_at

#end

#register_all_scope(self)
