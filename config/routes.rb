Rails.application.routes.draw do

  namespace :admin do
    resources :changes
    resources :preschools
  end

  root to: 'home#index'
end
