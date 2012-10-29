# encoding: utf-8
ActiveAdmin.register Teacher do
  menu priority: 8
  form do |f|
    f.inputs "基本資料" do
      f.input :name
      f.input :department
      f.input :phone
      f.input :cellphone
      f.input :tax_number
      f.input :avatar
      f.input :title, member_label: proc{|t| t.translation_for(:"zh-TW").title_name}
      f.input :email
      f.input :homepage
    end
    f.inputs "研究領域" do
      f.has_many :research_areas do |r|
        r.inputs do
          r.input :name
        end
        if r.object.id
          r.input :_destroy, :as => :boolean, :label => "delete"
        end
        r.form_buffers.last # to avoid bug with nil possibly being returned from the above
      end
    end
    f.inputs "學歷" do
      f.has_many :educational_backgrounds do |e|
        e.input :name
        e.input :require_year
        if e.object.id
          e.input :_destroy, :as => :boolean, :label => "delete"
        end
        e.form_buffers.last # to avoid bug with nil possibly being returned from the above
      end
    end
    f.inputs "任教課程" do
      f.has_many :courses do |c|
        c.input :name
        if c.object.id
          c.input :_destroy, :as => :boolean, :label => "delete"
        end
        c.form_buffers.last # to avoid bug with nil possibly being returned from the above
      end
    end
    f.buttons
  end
end
