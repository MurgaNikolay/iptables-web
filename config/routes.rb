Access::Application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'index#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'login', to: 'sessions#login', as: 'login'


  resources :sessions, only: [:create, :destroy]
  get 'users/current', to: 'users#index'
  resources :access_rules
  resources :nodes do
    resources :access_rules
    resources :security_groups
  end
  # resources :access_rules
  resources :security_groups do
    resources :access_rules
    resources :nodes
  end
  resources :nodes_security_groups

  # get 'node/:node_id/access_rules', to: 'node_access_rules#index', as: 'node_access_rules'
  # post 'node/:node_id/access_rules', to: 'node_access_rules#create'
  # delete 'node/:node_id/access_rules/:id', to: 'node_access_rules#destroy'
  #
  # get 'node/:node_id/nodes_security_groups', to: 'node_security_groups#index', as: 'node_security_groups'
  # post 'node/:node_id/nodes_security_groups', to: 'node_security_groups#create'
  # delete 'node/:node_id/nodes_security_groups/:id', to: 'node_security_groups#destroy'

  namespace :api do
    resources :access_rules, only: [:index]
    resources :nodes, only: [:show, :update]
  end
  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
