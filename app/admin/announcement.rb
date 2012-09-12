# encoding: utf-8
ActiveAdmin.register Announcement do     
  menu priority: 4
  form do |f|                         
    f.globalize_inputs :translations do |gf|
      gf.inputs "新公告"do
        gf.input :name, label: "公告名稱"
        gf.input :content, as: :ckeditor
        gf.input :locale, as: :hidden
      end
    end
    f.inputs do
      f.input :category, label: "公告類別", as: :radio,
              collection: Hash[AnnounceCategory.all.map do |c|
                                [" "+I18n.t("#{c.name}.name")+" "+I18n.t("#{c.name}.hint"),c.id]
                              end]
    end
    f.inputs do
      f.input :departments, as: :check_boxes, label: "公告至系所", hint: "可複選",
              :member_label => Proc.new {|d| " "+I18n.t("scopes.#{d.name}")}
    end
    f.inputs "有效期限" do
      #f.input :announce_date, label: "開始日期", as: :datepicker,
              #input_html: { value: f.object.announce_date || Date.today.strftime}
      f.input :due_date, label: "結束日期", as: :datepicker, 
              input_html: {value:f.object.due_date || Date.today.next_month.strftime }
    end
    f.buttons                         
  end #form do

  index do
    column :name
    column do |ann|
      div raw(ann.content)
    end
    column :announce_date
    column :due_date
  end

end                                   
