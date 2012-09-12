# encoding: utf-8
ActiveAdmin.register NewsReport do

  config.batch_actions = false
  menu priority: 6

  index :as => :block do |report|
    div class: "news_report" do
      h3 report.title
      div class: "content" do
        raw report.content
      end
      br
    end
  end

  filter :department
  filter :title
  filter :content

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
