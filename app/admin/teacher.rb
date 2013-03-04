# encoding: utf-8
ActiveAdmin.register Teacher do
  menu priority: 8, if: proc{ can?(:manage,Teacher)}, label: "教師資料", parent: "教師管理"

  controller.authorize_resource

  action_item { link_to "教師排序", teacher_ordering_admin_teachers_path  }

  collection_action :teacher_ordering, :method => :get do
    @teacher_titles = TeacherTitle.all
    #@teachers = Teacher.all 
  end

  member_action :gmba_pick_teacher, method: :post do
    @teacher.picked_by_gmba = params[:teacher][:picked_by_gmba]
    @teacher.save
    render :nothing => true
  end
  member_action :emba_pick_teacher, method: :post do
    @teacher.picked_by_emba = params[:teacher][:picked_by_emba]
    @teacher.save
    render :nothing => true
  end

  member_action :set_order, :method => :post do
    @teacher.front_end_order = params[:teacher][:front_end_order]
    @teacher.save
    render :nothing => true
  end

  form do |f|
    f.globalize_inputs :translations do |gf|
      gf.inputs "姓名與研究室" do
        gf.input :name, label: "姓名"
        gf.input :room, label: "研究室"
        gf.input :locale, as: :hidden
      end
    end
    f.inputs "基本資料" do
      f.input :department, label: "系所"
      f.input :phone, label: "電話"
      f.input :cellphone, label: '手機'
      f.input :tax_number, label: "傳真"
      f.input :avatar, label: "照片"
      f.input :teacher_title, label: "職稱", member_label: proc{|t| t.translation_for(:"zh-TW").title_name}
      f.input :joint_with, label: "合聘系所", hint: "若非合聘教師，此欄留空"
      f.input :email
      f.input :homepage, label: "個人網頁"
    end
    f.inputs "獲獎與經歷" do
      f.globalize_inputs :translations do |t|
        t.inputs do
          t.input :honor, label: "獲獎", input_html: { rows: 8 }
          t.input :history, label: "經歷", input_html: { rows: 8 }
          t.input :locale, as: :hidden
        end
      end
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
            ct.input :course_url, label: "課程連結(非必要)"
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
  end # form

  index do
    column :name
    column :phone
    column :cellphone
    column :email
    column :room
    column :department
    default_actions
  end

  filter :department
  filter :name
  filter :email
  filter :room
  filter :cellphone
  filter :phone
end
