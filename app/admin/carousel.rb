# encoding: utf-8
ActiveAdmin.register Carousel do
  menu if: proc{ can?(:manage,Carousel) }, label: "首頁幻燈片"
  form do |f|
    f.inputs do
      f.input :picture
      #f.input :title
      f.input :link_url
      #f.input :caption, input_html: { rows: 5 }
      f.input :department, label: "所屬系所", include_blank: false,
              member_label: Proc.new {|d| " "+I18n.t("scopes.#{d.name}")}
    end
    f.globalize_inputs :translations do |gf|
      gf.inputs "標題與說明" do
        gf.input :title
        gf.input :caption, input_html: { rows: 5 }
        gf.input :locale, as: :hidden
      end
    end
    f.actions
  end

  filter :title
  filter :caption
end
