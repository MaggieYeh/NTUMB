# encoding: utf-8
ActiveAdmin.register Announcement do     
  menu :priority => 11, :label => "公告"
  form do |f|                         
    f.inputs "新公告" do
      f.input :name, label: "公告名稱"
      f.input :category, label: "公告類別", as: :radio,
              collection: Hash[AnnounceCategory.all.map do |c|
                                [" "+I18n.t("#{c.name}.name")+" "+I18n.t("#{c.name}.hint"),c.id]
                              end]
    end
    f.inputs "有效期限" do
      f.input :announce_date, label: "開始日期", as: :datepicker,
              input_html: { value: f.object.announce_date || Date.today.strftime}
      f.input :due_date, label: "結束日期", as: :datepicker, 
              input_html: {value:f.object.due_date || Date.today.next_month.strftime }
    end
    f.inputs "公告內容" do
      f.input :content, :as => :ckeditor ,:input_html => { :height => 300 }
    end
    f.inputs "公告至" do
      f.input :departments, as: :check_boxes,
              :member_label => Proc.new {|d| " "+I18n.t("scopes.#{d.name}")}
    end
    f.buttons                         
  end 
end                                   
