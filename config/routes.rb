Rails.application.routes.draw do
constraints( -> (req) { !req.env['HTTP_USER_AGENT'].match?(/Firefox\//) } ) do
  get 'admin' => 'admin#index'
  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  get 'sessions/create'
  get 'sessions/destroy'

  get 'users/line_Items', to: 'users#line_Items'
  get 'users/orders', to: 'users#orders'

  get 'my-orders', to: redirect('/users/orders')
  get 'my-items', to: redirect('/users/line_Items')
  resources :users

  resources :products, path: 'books' do
    get :who_bought, on: :member
  end

  resources :support_requests, only: [ :index, :update ]

  scope '(:locale)' do
    resources :orders
    resources :line_items
    resources :carts
    root 'store#index', as:'store_index', via: :all
  end

  namespace 'admin' do
    get 'reports', to: 'reports#index'
    post 'reports', to: 'reports#index'
    resources 'categories' , only: [:index] do
      get 'books', to: 'categories#products', constraints: { category_id: /\d+/ }
      get 'books', to: redirect('/')
    end
  end
end

root 'store#index'

end
