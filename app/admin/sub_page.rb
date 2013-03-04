#!/bin/env ruby
# encoding: utf-8
ActiveAdmin.register SubPage do     
  menu label: "零散頁面管理", if: proc{ can?(:manage, SubPage) }, parent: "內容頁面"
  controller.authorize_resource

  collection_action :js_new, method: :get do
    @sub_page = SubPage.new
    @remote = true
    @url = "admin/js_create"
    @method = :post
  end

  member_action :js_edit, method: :get do
    @sub_page = SubPage.find(params[:id])
    @remote = true
    @url = "admin/js_update"
    @method = :put
  end

  collection_action :js_create, method: :post do
    @sub_page = params[:sub_page]
    @sub_page.save
    respond_to do |format|
      format.js
    end
  end

  member_action :js_update, method: :put do
    @sub_page = params[:sub_page]
    @sub_page.save
    respond_to do |format|
      format.js
    end
  end

  filter :department, label: "系所"
  filter :content, label: "內容"
  filter :title, label: "標題"
  filter :locale, label: "語言", as: :select, collection: ["en","zh-TW"] 

  index do
    column :title
    column "語言" do |sub_p|
      if sub_p.locale == "en"
        "English"
      elsif sub_p.locale == "zh-TW"
        "中文"
      end
    end
    column "系所", :department_name
    #column "系所" do |sub_p|
      #I18n.t("scopes.#{sub_p.department.name}")
    #end
    column "連結", :path
    
    default_actions
  end

  form partial: "form"
end
