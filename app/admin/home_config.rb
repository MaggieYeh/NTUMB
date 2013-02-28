# encoding: utf-8
ActiveAdmin.register HomePageConfig do     
  menu if: proc{ can?(:manage,HomePageConfig) }, label: "首頁設定"
  controller.authorize_resource
  config.filters = false
  config.clear_action_items!

  index do
    column "系所" do |config|
      link_to(I18n.t("front_end.#{config.department.name}"), edit_admin_home_page_config_path(config))
    end
    column "聯絡資訊" do |config|
      config.contact_info
    end
    column "" do |config|
      links = "".html_safe
      links += link_to("檢視", admin_home_page_config_path(config), class: "member_link view_link")
      links += link_to("編輯", edit_admin_home_page_config_path(config), class: "member_link edit_link")
      links
    end
  end

  form do |f|
    f.inputs "首頁設定" do
      f.input :contact_info, label: "聯絡信箱"
      f.input :phone_one, label: "聯絡電話1"
      f.input :phone_two, label: "聯絡電話2"
      f.input :tax_num, label: "傳真號碼"
      f.input :address, label: "聯絡地址(中文)"
      f.input :eng_address, label: "聯絡地址(英文)"
      counter = 0
      f.has_many :home_page_tab_fields, label: "首頁公告分頁" do |tab|
        counter += 1
        tab.inputs "標籤#{counter}" do
          tab.input :visible, label: "顯示此標籤"
          tab.input :announce_categories, label: "此標籤所要顯示的公告分類", as: :check_boxes,
                    member_label: proc{|t| " " + I18n.t("ann_category.#{t.name}.name")+ " " + \
                                        I18n.t("ann_category.#{t.name}.hint")}
                    #collection: Hash[AnnounceCategory.all.map do |c|
                                    #[" "+I18n.t("ann_category.#{c.name}.name") + " " + \
                                     #I18n.t("ann_category.#{c.name}.hint"),c.id]
                                    #end]
          tab.input :youtube_channel_account, label: "Youtube頻道帳號", 
                  hint: "若輸入頻道帳號，此標籤將不顯示上欄位所勾選之公告，而會試圖抓取該頻道內容"
          tab.globalize_inputs :translations do |gf|
            gf.inputs "標籤名稱" do
              gf.input :first_name, label: "標籤前半段"
              gf.input :last_name, label: "標籤後半段"
              gf.input :locale, as: :hidden
            end
          end
        end
        tab.form_buffers.last # to avoid bug with nil possibly being returned from the above
      end
    end
    f.actions 
  end

end
