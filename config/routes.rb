Rails.application.routes.draw do

  namespace :admin do
    resources :changes
    resources :preschools
  end

  get 'position/:latitude,:longitude', to: 'home#index', latitude: /\d+\.\d+/, longitude: /\d+\.\d+/

  root to: 'home#index'
end
