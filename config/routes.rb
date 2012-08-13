NTUMB::Application.routes.draw do
  #get "pages/view"

  mount Ckeditor::Engine => '/ckeditor'

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config
  
  #Department.pluck("name").each do |dname|
    #match "#{dname}/*path" => "#{dname.downcase}_pages#view"
    #match "#{dname.upcase}/*path" => "#{dname.downcase}_pages#view"
    #match "#{dname.downcase}/*path" => "#{dname.downcase}_pages#view"
  #end
  #match "/*path" => "management_pages#view"
  #match ":dname/*path" => 'pages#view'
  match "/*path" => 'pages#view'#, :as => :page

  #NTUMB::Application.routes.named_routes.module.module_eval do
    #def page_path(page, options = {})
      ##binding.pry
      #page.path
    #end
  #end
  filter :department, :exclude => %r(^/admin/)
  filter :locale, :exclude => %r(^/admin/)

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
