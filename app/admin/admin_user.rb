ActiveAdmin.register AdminUser do     
  menu if: proc{ can?(:manage, AdminUser) }, priority: 1
  controller.authorize_resource 

  index do                            
    column :email                     
    column :current_sign_in_at        
    column :last_sign_in_at           
    column :sign_in_count             
    default_actions                   
  end                                 

  filter :email                       

  form do |f|                         
    f.inputs "Admin Details" do       
      f.input :email                  
      f.input :password               
      f.input :password_confirmation  
      f.input :roles, :as => :check_boxes, :member_label => :role
    end                               
    f.buttons                         
  end                                 
end                                   
