Rails.application.routes.draw do

  constraints subdomain: 'admin' do
    namespace :admin, path: '/' do
      root 'root#index'
      resources :community, as: :communities, controller: :communities
      resources :sailing, as: :sailings, controller: :sailings, only: [:create, :new], path: 'community/:community_id/sailing'
      resources :sailing, as: :sailings, controller: :sailings, only: [:show, :edit, :update, :destroy]
      resources :participant, as: :participants, controller: :participants, only: [:create], path: 'sailing/:sailing_id/participant'
      resources :participant, as: :participants, controller: :participants, only: [:destroy]
      resources :comment, as: :comments, controller: :comments, only: [:create, :new], path: 'sailing/:sailing_id/comment'
      resources :comment, as: :comments, controller: :comments, only: [:edit, :update, :destroy]
    end
  end

  get 'user/signin'

  root 'root#index'

  [ :about, :company, :terms, :privacy, :owner ].each do |key|
    get key, to: "root##{key}", as: key
  end

  post :contact, to: 'root#contact', as: :contact

  devise_for :users,
    controllers: { omniauth_callbacks: 'omniauth_callbacks' },
    skip: [ :sessions, :registrations, :password ]

  devise_scope :user do
    get 'signin',  to: 'user#signin',             as: :new_user_session
    get 'signout', to: 'devise/sessions#destroy', as: :destroy_user_session
  end

  resources :participant, as: :participants, path: 'sailing/:sailing_id/participants', controller: :participants
  resources :community, as: :communities, controller: :communities, only: [:show] do
    member do
      post :interest
      post :another_time
    end
  end
  resources :member, as: :members, path: 'community/:community_id/members', controller: :members

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
