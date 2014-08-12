Rails.application.routes.draw do
  resources :banners

  resources :courses

  resources :students do
    collection do 
      post 'join_course'
      get 'search'
      get 'score'
    end
  end

  resources :messages

  resources :members do 
    collection do 
      get 'sel'
    end
    member do 
      post 'assoc_user'
    end
    resources :fees, except: [:show]
  end

  resources :categories

  resources :pages

  devise_for :users, :skip => [:registrations] 
    as :user do
      get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'    
      put 'users/:id' => 'devise/registrations#update', :as => 'user_registration'            
    end
  mount Ckeditor::Engine => '/ckeditor'
  
  get 'home/index'
  get 'home/control', as: 'control'

  get 'register', to: 'students#new'
  get 'reg_finished/:id', to: 'students#register_finished', as: 'register_finished'

  get 'p/:first_cat/(:second_cat)/(:pid)', to:'home#category', as: 'cat'
  namespace :admin do 
    resources :users 
  end

  root 'home#index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
