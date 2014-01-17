GoodReadsClone::Application.routes.draw do
  resources :users, :only => [:index, :create, :update, :show, :new, :destroy] do
    collection do
      get 'activate'
    end
    resources :follows, only: [:create, :destroy]
    # get 'recommendations', :to => 'users#recommendations'
    post 'approve', :to => 'users#send_activation_email'
  end

  resource :session, :only => [:create, :destroy, :new] do
    post 'mail_request'
  end

  get 'request', :to => 'sessions#request_entry'

  resources :books, :only => [:index, :show, :create] do
    resource :like, :only => [:create, :destroy]
    post 'review', :to => 'posts#create_review'
  end

  resource :admin, :only => [:index] do
    get 'home', :to => 'admins#index'
    get 'requests', :to => 'admins#activation'
    get 'users'
    get 'clubs'
  end

  resources :clubs, :only => [:index, :create, :show, :destroy] do
    post 'filter', :to => 'clubs#filter_show'
    post 'add_book', :to => 'clubs#add_book'
    resources :posts, :only => [:create]
    resources :memberships, only: [:create]
  end

  resources :comments, only: [:index, :show, :destroy]

  resources :posts, only: [:show, :destroy] do
    resources :comments, only: [:new, :create]
  end

  resources :notifications, only: [:index]

  root :to => "home#index"

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
