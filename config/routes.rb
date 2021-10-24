Rails.application.routes.draw do

  devise_for :admin, :controllers => {
 :registrations => 'admin/registrations',
 :sessions => 'admin/sessions'}


  namespace :admin do
    resources :items
    resources :customers, only: [:edit, :show, :index, :update]
  end

  scope module: :public do
    devise_for :customers, :controllers => {
 :registrations => 'public/registrations',
 :sessions => 'public/sessions'}
 resources :customers, only: [:edit, :show, :update]

  end
end

