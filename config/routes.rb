Rails.application.routes.draw do

  get 'admin' => 'admin#index'
  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end
  # get 'admin/index'
  # get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'

  get 'users/line_Items', to: 'users#line_Items'
  get 'users/orders', to: 'users#orders'

  resources :users

  resources :products do
    get :who_bought, on: :member
  end

  resources :support_requests, only: [ :index, :update ]

  scope '(:locale)' do
    resources :orders
    resources :line_items
    resources :carts
    root 'store#index', as:'store_index', via: :all
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
