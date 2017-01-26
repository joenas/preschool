Rails.application.routes.draw do

  namespace :admin do
    resources :changes
  end

  root to: 'home#index'
end
