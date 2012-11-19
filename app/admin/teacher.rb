# encoding: utf-8
ActiveAdmin.register Teacher do
  menu priority: 8, if: proc{ can?(:manage,Teacher)}
  controller.authorize_resource
  form do |f|
    f.globalize_inputs :translations do |gf|
      gf.inputs "姓名與研究室" do
        gf.input :name, label: "姓名"
        gf.input :room, label: "研究室"
        gf.input :locale, as: :hidden
      end
    end
    f.inputs "基本資料" do
      #f.input :name
      f.input :department, label: "系所"
      f.input :phone, label: "電話"
      f.input :cellphone, label: '手機'
      f.input :tax_number, label: "傳真"
      f.input :avatar, label: "照片"
      f.input :teacher_title, member_label: proc{|t| t.translation_for(:"zh-TW").title_name}
      f.input :email
      f.input :homepage, label: "個人網頁"
    end
    f.inputs "研究領域" do
      f.has_many :research_areas do |r|
        r.globalize_inputs :translations do |rt|
          rt.inputs do
            rt.input :name, label: "研究領域"
            rt.input :locale, as: :hidden
          end
        end
        #r.inputs do
          #r.input :name
        #end
        if r.object.id
          r.input :_destroy, :as => :boolean, :label => "delete"
        end
        r.form_buffers.last # to avoid bug with nil possibly being returned from the above
      end
    end
    f.inputs "學歷" do
      f.has_many :educational_backgrounds do |e|
        #e.input :name, label: "學位名稱"
        e.globalize_inputs :translations do |et|
          et.inputs do
            et.input :name, label: "學位名稱"
            et.input :locale, as: :hidden
          end
        end
        e.input :require_year, label: "取得年份"
        if e.object.id
          e.input :_destroy, :as => :boolean, :label => "delete"
        end
        e.form_buffers.last # to avoid bug with nil possibly being returned from the above
      end
    end
    f.inputs "任教課程" do
      f.has_many :courses do |c|
        #c.input :name
        c.globalize_inputs :translations do |ct|
          ct.inputs do
            ct.input :name, label: "課程名稱"
            ct.input :locale, as: :hidden
          end
        end
        if c.object.id
          c.input :_destroy, :as => :boolean, :label => "delete"
        end
        c.form_buffers.last # to avoid bug with nil possibly being returned from the above
      end
    end
    f.actions
  end
end
