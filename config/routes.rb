Rails.application.routes.draw do

  namespace :admin do
    resources :site_changes
    resources :preschools
    root to: 'preschools#index'
  end

  get 'position/:latitude,:longitude', to: 'home#index', latitude: /\d+\.\d+/, longitude: /\d+\.\d+/

  root to: 'home#index'
end
