Rails.application.routes.draw do

  namespace :admin do
    resources :site_changes, only: [:create, :update]
    resources :preschools, only: [:index, :show]
    root to: 'preschools#index'
  end

  get 'position/:latitude,:longitude', to: 'home#index', latitude: /\d+\.\d+/, longitude: /\d+\.\d+/

  root to: 'home#index'
end
