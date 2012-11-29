# encoding: utf-8
ActiveAdmin.register NewsReport do

  config.batch_actions = false
  menu priority: 6, if: proc{ can?(:manage,NewsReport) }
  controller.authorize_resource

  #index :as => :block do |report|
    #missing_title_translation_zh = report.translation_for(:"zh-TW").title.to_s.empty?
    #missing_title_translation_en = report.translation_for(:en).title.to_s.empty?
    #missing_content_translation_zh = report.translation_for(:"zh-TW").content.to_s.empty?
    #missing_content_translation_en = report.translation_for(:en).content.to_s.empty?
    #missing_translation_zh = missing_content_translation_zh || missing_title_translation_zh
    #missing_translation_en = missing_content_translation_en || missing_title_translation_en
    #div class: "admin_tabbed_item", for: report do
      #ul do
        #li do
          #if missing_translation_zh
            #a "中文", href: "#zh-TW_report_#{report.id}", class: "missing_translation"
          #else
            #a "中文", href: "#zh-TW_report_#{report.id}"
          #end
        #end
        #li do
          #if missing_translation_en
            #a "英文", href: "#en_report_#{report.id}", class: "missing_translation"
          #else
            #a "英文", href: "#en_report_#{report.id}"
          #end
        #end
        #div class: "item_actions" do
          #span do
            #link_to "詳細資訊", admin_news_report_url(report)
          #end
          #span do
            #link_to "編輯", edit_admin_news_report_url(report)
          #end
          #span do
            #link_to "刪除", admin_news_report_url(report), method: :delete, data: {confirm: I18n.t("active_admin.delete_confirmation") }
          #end
        #end
      #end
      #div id: "zh-TW_report_#{report.id}", class: "tabbed_item_content" do
        #h3 report.translation_for(:"zh-TW").title
        #span "發布日期：#{report.created_at.to_date.strftime("%Y/%m/%d")}"
        #hr
        #div raw(HTML_Truncator.truncate(report.translation_for(:"zh-TW").content,50))
      #end
      #div id: "en_report_#{report.id}", class: "tabbed_item_content" do
        #h3 report.translation_for(:en).title
        #span "發布日期：#{report.created_at.to_date.strftime("%Y/%m/%d")}"
        #hr
        #div raw(HTML_Truncator.truncate(report.translation_for(:en).content,50))
      #end
    #end #div for report
  #end #index
  #
  index do
    column "新聞標題" do |report|
      link_to report.title, admin_news_report_path(report)
    end
    column :department
    column "有英文版本？" do |ann|
      ann_en_ver = ann.translation_for(:en)
      if ann_en_ver.content.to_s.empty? or ann_en_ver.title.to_s.empty?
        span "沒有", class: "missing_translation"
      else
        span "有"
      end
    end
    column :announce_date
    default_actions                   
  end

  show do |report|
    attributes_table do
      row :title
      row :created_at
      row :department
      row "內容" do
        div do
          raw report.content
        end
      end
    end
  end

  filter :department
  filter :translations_title, label: "標題", as: :string
  filter :translations_content, label: "內容", as: :string

  form do |f|
    f.globalize_inputs :translations do |gf|
      gf.inputs "新報導"do
        gf.input :title, label: "標題"
        gf.input :content, label: "內容", as: :ckeditor, input_html: { height: 400}
        gf.input :locale, as: :hidden
      end
    end
    f.inputs do
      date_value = f.object.announce_date || (f.object.created_at.nil? ? Date.today.strftime : f.object.created_at.to_date)
      f.input :announce_date, label: "發佈日期", as: :datepicker,
              input_html: {value: date_value }
      f.input :department, label: "所屬系所", include_blank: false,
              member_label: Proc.new {|d| " "+I18n.t("scopes.#{d.name}")}
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
    f.inputs "預覽" do
      f.input :preview, label: "預覽圖", hint: "請盡量選擇16:9左右的寬照片"
      #f.input :preview_text, label: "預覽文字", hint: "70個中文字以內。留空則自動擷取"
      f.input :text_up, label: "預覽方式", as: :radio, 
               collection: {"圖片在上" => false, "文字在上" => true},
               hint: "若不選則預設圖片在上"
      f.input :preview_color, label: "顏色", as: :radio,
               collection: Hash[ [["隨機", "random"]] + StickerColor::COLOR_NAMES.zip(StickerColor::COLORS)]
    end
    f.globalize_inputs :translations do |gf|
      gf.inputs "首頁預覽文字" do
        gf.input :preview_text, label: "預覽文字", hint: "70個中文字以內。留空則自動擷取"
        gf.input :locale, as: :hidden
      end
    end
    f.actions
  end
end
