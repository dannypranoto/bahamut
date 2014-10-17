Rails.application.routes.draw do
  devise_for :customers, controllers: { :registrations => 'customers/registrations'}

  resources :sessions, only: [:login, :create, :destroy, :dashboard, :top_up, :profile]

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'connect_pages#home'

  match '/about', to: 'connect_pages#about', via: 'get'
  match '/contact', to: 'connect_pages#contact', via: 'get'
  match '/pricing', to: 'connect_pages#pricing', via: 'get'
  match '/product', to: 'connect_pages#product', via: 'get'
  match '/register', to: 'users#register', via: 'get'
  match '/register_success', to: 'users#register_success', via: 'get'
  match '/login', to: 'sessions#login', via: 'get'
  match '/dashboard', to: 'sessions#dashboard', via: 'get'
  match '/top_up', to: 'sessions#top_up', via: 'get'
  match '/profile', to: 'sessions#profile', via: 'get'
  match '/logout', to: 'sessions#destroy', via: 'delete'



  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

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
