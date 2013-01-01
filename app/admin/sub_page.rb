#!/bin/env ruby
# encoding: utf-8
ActiveAdmin.register SubPage do     
  menu false
  controller do
    def create
      create! do |format|
        format.js
      end
    end
  end
  form remote: true do |f|
    f.inputs "新頁面" do
      f.input :title, label: "標題"
      f.input :content, label: "內容", as: :ckeditor, input_html: { height: 500 }
      #f.input :page_id, as: :hidden,
              #:input_html => { :value => f.object.page_id || params[:page_id] }
      f.input :locale, as: :hidden,
              input_html: { :value => f.object.locale || params[:sub_page_locale] }
    end
    f.actions do
      f.action :submit, label: "新增內容子頁面"
      f.action :cancel, label: "取消", as: :link, url: "javascript:window.parent.closedialog();"
      #f.action :cancel, label: "取消", as: :button,
                #input_html: { onClick: "window.parent.closedialog();" }
    end
  end
end
