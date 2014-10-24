Aquakids::Application.routes.draw do
  
  resources :payment_plan_instalments

  resources :roles

  resources :referrals

  post "/schedules/delete_many"

  get "schedules/classes"

  get "autoclasses/autoclass"
  
  post "autoclasses/create_schedules"
  
  get "/schedules/ransack_search"
  get "/schedules/ransack_read_only_search"
  
  get "/scheduleregs/registrations_by_schedule"

  get "/scheduleregs/flashrefresh"

  get "/children/childrenByParentForSchedule"
  
  get "/children/childrenForSchedule"

  get "/programs/payment_plansForSchedule"

  get "/parents/parentsByLocation"  

  get "/parents/payments_due"
  
  get "/parents/get_payments_due"

  
  resources :copyclasses do
    collection do
      get :copy_classes
      put :copy_classes_update
    end
  end

  root :to => "static#home"

  devise_for :users, path_names: {sign_in: "login", sign_out: "logout"}

  resources :skills

  resources :teachers

  resources :programs

  resources :types

  resources :activities

  resources :levels

  resources :schedules 
  
  resources :zones

  resources :facilities

  resources :locations

  resources :children

  resources :parents

  resources :days

  resources :scheduleregs

  resources :users

  resources :payment_plans

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
