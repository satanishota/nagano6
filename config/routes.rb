Rails.application.routes.draw do


  namespace :public do
    get 'items/show'
    get 'items/index'
  end
  namespace :public do
    get 'cart_items/index'
  end
  devise_for :admin, :controllers => {
 :registrations => 'admin/registrations',
 :sessions => 'admin/sessions'}



  namespace :admin do
    resources :items
    resources :customers, only: [:edit, :show, :index, :update]
    resources :orders, only: [:show,:update]
  end

  scope module: :public do
    devise_for :customers, :controllers => {
 :registrations => 'public/registrations',
 :sessions => 'public/sessions'}
 resources :customers, only: [:edit, :update]
 get 'customers/my_page' => 'customers#show'
 get 'customers/unsubscribe' => 'customers#unsubscribe'
 patch 'customers/withdraw' => 'customers#withdraw'
 root to: 'homes#top'
 get 'about' => 'homes#about'
 resources :cart_items, only: [:index, :update, :create, :delete]


  end
end

