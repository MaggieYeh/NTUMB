# encoding: utf-8
ActiveAdmin.register DocumentCategory do     
  menu parent: "上傳文件", if: proc{ can?(:manage,DocumentCategory) }
  controller.authorize_resource
end
