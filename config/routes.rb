Caliburn::Application.routes.draw do
  resources :payment_notifications, :only => :create

  devise_for :users

  resources :categories

  match 'shopping_basket' => "basket#show", :as => :basket
  match 'empty_basket' => "basket#destroy", :as => :empty_basket
  match 'about' => "pages#about", :as => :about
  match 'contact' => "pages#contact", :as => :contact
  match 'terms' => "pages#terms", :as => :terms
  match 'shop/feed' => 'shop#feed'
  match 'shop(/*ancestors)/:category/page/:page' => 'shop#index'
  match 'shop(/*ancestors)/:category' => 'shop#index', :as => :shop
  match 'shop' => 'shop#index', :as => :shop_overview
  
  devise_scope :user do 
    get "/admin" => "devise/sessions#new"
  end
  
  resources :line_items

  resources :products

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
  root :to => 'pages#home'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
