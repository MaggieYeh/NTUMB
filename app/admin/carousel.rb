# encoding: utf-8
ActiveAdmin.register Carousel do
  form do |f|
    f.inputs do
      f.input :picture
      f.input :title
      f.input :link_url
      f.input :caption, input_html: { rows: 5 }
      f.input :department, label: "所屬系所", include_blank: false,
              member_label: Proc.new {|d| " "+I18n.t("scopes.#{d.name}")}
    end
    f.actions
  end

  filter :title
  filter :caption
end
