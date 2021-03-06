# Require all route constraints
Dir["#{::Rails.root.to_s}/lib/route_constraints/*"].each { |path| 
  require path 
}

RailsShop::Application.routes.draw do
  ActiveAdmin.routes(self)
  
  devise_for :admin_users, ActiveAdmin::Devise.config
  #devise_for :customers
  #match '/customers/edit', 
  #  :controller =>'Devise::RegistrationsController', 
  #  :action => 'edit', :as => 'customer_root'

  scope '/catalog', :controller => :catalog do
    get   '', :action => :index, :as => 'catalog'
    
    # Constraint class in lib/GoodConstraint.rb
    get '/*path/goods/:id', :action => :good, :as => 'good', :constraints => GoodConstraint
    # Constraint class in lib/CategoryConstraint.rb
    get '/*path', :action => :category,       :as => 'category', :constraints => CategoryConstraint
  end

  scope '/blog', :controller => :events, :constraints => BlogConstraint do
    get '/:name', :action => :index, :as => 'blog'
    get '/:name/:id', :action => :show, :as => 'blog_event'
  end

  scope :controller => :site do
    # Constraint class in lib/StaticPageConstraint.rb
    get '/page/*path', :action => :static_page, :as => 'static_page', :constraints => StaticPageConstraint
  end
  
  resources :requests, :only => [:new, :create] do
    collection do
      get :express
      
      get :express_moscow
      get :express_region
      get :express_commerce
      get :express_residential
    end
  end
  
  root :to => 'site#index'

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
  # root :to => 'shop#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
