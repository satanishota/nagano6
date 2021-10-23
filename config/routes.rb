Rails.application.routes.draw do

  devise_for :admin, :controllers => {
 :registrations => 'admin/registrations',
 :sessions => 'admin/sessions'}


Rails.application.routes.draw do
  namespace :public do
    get 'customers/show'
    get 'customers/edit'
  end
  scope module: :public do
    devise_for :customers, :controllers => {
 :registrations => 'public/registrations',
 :sessions => 'public/sessions'}
 resources :customers, only: [:edit, :show, :update]

  end
end
end

