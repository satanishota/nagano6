Rails.application.routes.draw do
  devise_for :admin, :controllers => {
    :registrations => 'admin/registrations',
    :sessions => 'admin/sessions',
  }

  namespace :admin do
    resources :items
    resources :customers, only: [:edit, :show, :index, :update]
    resources :orders, only: [:show, :update]
    root to: 'homes#top'
  end

  scope module: :public do
    devise_for :customers, :controllers => {
      :registrations => 'public/registrations',
      :sessions => 'public/sessions',
    }
    patch 'customers/withdraw' => 'customers#withdraw'
    get 'customers/my_page' => 'customers#show'
    get 'customers/unsubscribe' => 'customers#unsubscribe'
    resources :customers, only: [:edit, :update]
    root to: 'homes#top'
    get 'about' => 'homes#about'
    delete 'cart_items' => 'cart_items#destroy_all'
    resources :cart_items, only: [:index, :update, :create, :destroy]
    resources :items, only: [:index, :show]
    post 'orders/confirm' => 'orders#confirm'
    get 'orders/complete' => 'orders#complete'
    resources :orders, only: [:new, :index, :show, :create]
    resources :addresses, only: [:edit, :index, :update, :create, :destroy]
  end
end
