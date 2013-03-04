# encoding: utf-8
[["EMBA_pick_teacher","EMBA"],["GMBA_pick_teacher","GMBA"]].each do |page,department|
  ActiveAdmin.register_page page do
    menu label: "#{department} 教師選擇", if: proc{ can?(:pick_teacher,AdminUser) }, priority: 20,
         parent: "教師管理"
    content do
      render partial: "admin/shared/teacher_picking", locals: { department_name: department }
    end
  end
end
