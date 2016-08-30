Rails.application.routes.draw do
  
  root 'dashboard#index'
  devise_for :users, controllers: { registrations: "registrations", 
                                  omniauth_callbacks: "omniauth_callbacks"}

  resources :friends, only: [:index, :destroy]
  resources :friend_requests, except: [:edit, :show]
  get 'sent_requests', to: 'friend_requests#sent_requests'

  resources :posts do
    
    resources :comments, only: [:create, :destroy]
  end
  get '/post/my_blogs', to: 'posts#my_blogs'
  post '/rate' => 'rater#create', :as => 'rate'

  resources :comments, only: :create do
    member do
      get :liked_by
    end
    resources :likes, only: [:create, :destroy]
  end  
  
  resources :users, only: [:index, :edit, :update, :show] do
    member do
      get :following, :followers
    end
  end
  resources :relationships,  only: [:create, :destroy]

  resources :subscribes, only: :create

  get '*a', :to => 'errors#routing'
 
  # get '/post/my_blogs', to: 'posts#my_blogs', as: 'my_blogs'
  # post 'users/auth/twitter/callback', to: 'sessions#create'

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
