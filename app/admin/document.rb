# encoding: utf-8
ActiveAdmin.register Document do     
  menu parent: "上傳文件"
  form do |f|
    f.inputs "上傳檔案" do
      f.input :discription, input_html: { rows: 5 }
      f.input :document_file
      f.input :category
      f.input :department,
              :member_label => Proc.new {|d| " "+I18n.t("scopes.#{d.name}")}
    end
    f.buttons
  end
end
