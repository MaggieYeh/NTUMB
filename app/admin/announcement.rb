# encoding: utf-8
ActiveAdmin.register Announcement do     
  menu priority: 4, if: proc{ can?(:manage,Announcement) }
  controller.authorize_resource
  config.sort_order = "announce_date_desc"

  filter :department
  filter :announce_category, collection: Hash[AnnounceCategory.all.map do |c|
                                      [I18n.t("#{c.name}.name"),c.id]
                                    end]
  filter :translations_name, label: "公告名稱", as: :string
  filter :translations_content, label: "公告內容", as: :string
  filter :created_at, label: "發布日期"

  member_action :pick_by_man, method: :post do
    @announcement.picked_by_management = params[:announcement][:picked_by_management]
    @announcement.save
    render nothing: true
  end

  form do |f|                         
    f.inputs "新公告" do
      f.input :sticky, label: "置頂"
      f.globalize_inputs :translations do |gf|
        gf.inputs "新公告"do
          gf.input :name, label: "公告名稱"
          gf.input :title_url, label: "標題連結(非必要)"
          gf.input :content, label: "公告內容", as: :ckeditor,
                   input_html: { rows: 10 }
          gf.input :locale, as: :hidden
        end
      end
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
    f.inputs do
      f.input :announce_category, label: "公告類別", as: :radio,
              collection: Hash[AnnounceCategory.all.map do |c|
                                [" "+I18n.t("ann_category.#{c.name}.name") + " " + \
                                 I18n.t("ann_category.#{c.name}.hint"),c.id]
                              end]
    end
    f.inputs do
      f.input :department, as: :radio, label: "公告至系所",
              :member_label => Proc.new {|d| " "+I18n.t("scopes.#{d.name}")}
    end
    f.inputs do
      f.input :announce_date, label: "公告開始日期", as: :datepicker, 
              input_html: {value:f.object.announce_date || Date.today.strftime }
      #f.input :due_date, label: "公告結束日期", as: :datepicker, 
              #input_html: {value:f.object.due_date || Date.today.next_month.strftime }
    end
    f.actions
  end #form do

  #index as: :tabbed_table, tabs: %w[中文 英文] do |announcement|
  #end

  show do |ann|
    attributes_table do
      row :name
      row :announce_date
      row :announce_category do
        I18n.t("#{ann.announce_category.name}.name")
      end
      row :department
      row "內容" do
        div do
          raw ann.content
        end
      end
    end
  end

  index do
    column "公告名稱" do |ann|
      link_to ann.name, admin_announcement_path(ann)
    end
    column :department
    column "有英文版本？" do |ann|
      ann_en_ver = ann.translation_for(:en)
      if ann_en_ver.content.to_s.empty? or ann_en_ver.name.to_s.empty?
        span "沒有", class: "missing_translation"
      else
        span "有"
      end
    end
    column :announce_date
    default_actions                   
    if can? :pick_announcement, AdminUser
      column "作為管院公告" do |ann|
        div do
          render partial: "pick_ann", locals: { ann: ann }
        end
      end
    end
  end

  #index as: :block do |announcement| 
    #missing_title_translation_zh = announcement.translation_for(:"zh-TW").name.to_s.empty?
    #missing_title_translation_en = announcement.translation_for(:en).name.to_s.empty?
    #missing_content_translation_zh = announcement.translation_for(:"zh-TW").content.to_s.empty?
    #missing_content_translation_en = announcement.translation_for(:en).content.to_s.empty?
    #missing_translation_zh = missing_content_translation_zh || missing_title_translation_zh
    #missing_translation_en = missing_content_translation_en || missing_title_translation_en
    #div class: "admin_tabbed_item", for: announcement do
      #ul do
        #li do
          #if missing_translation_zh
            #a "中文", href: "#zh-TW_announcement_#{announcement.id}", class: "missing_translation"
          #else
            #a "中文", href: "#zh-TW_announcement_#{announcement.id}"
          #end
        #end
        #li do
          #if missing_translation_en
            #a "英文", href: "#en_announcement_#{announcement.id}", class: "missing_translation"
          #else
            #a "英文", href: "#en_announcement_#{announcement.id}"
          #end
        #end
        #div class: "item_actions" do
          #span do
            #link_to "詳細資訊", admin_announcement_url(announcement)
          #end
          #span do
            #link_to "編輯", edit_admin_announcement_url(announcement)
          #end
          #span do
            #link_to "刪除", admin_announcement_url(announcement), method: :delete, data: {confirm: I18n.t("active_admin.delete_confirmation") }
        #end
      #end
    #end
      #div id: "zh-TW_announcement_#{announcement.id}", class: "tabbed_item_content" do
        #h3 announcement.translation_for(:"zh-TW").name
        #span announcement.announce_date.strftime("%Y/%m/%d") + " ~ " + 
             #announcement.due_date.strftime("%Y/%m/%d")
        #hr
        #div raw(announcement.translation_for(:"zh-TW").content)
      #end
      #div id: "en_announcement_#{announcement.id}", class: "tabbed_item_content" do
        #h3 announcement.translation_for(:en).name
        #span announcement.announce_date.strftime("%Y/%m/%d") + " ~ " + 
             #announcement.due_date.strftime("%Y/%m/%d")
        #hr
        #div raw(announcement.translation_for(:en).content)
      #end
    #end #div for announcement
  #end #index

end                                   
