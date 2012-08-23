# encoding: utf-8
ActiveAdmin.register NewsReport do
  #index :as => :blog do
    #title :title
    #body :content
  #end
  menu :priority => 12, :label => "新聞報導"
  form do |f|
    f.inputs do
      f.input :title
      f.input :content, as: :ckeditor, input_html: { height: 400}
      f.input :department,
              :member_label => Proc.new {|d| " "+I18n.t("scopes.#{d.name}")}
    end
    f.buttons
  end
end
