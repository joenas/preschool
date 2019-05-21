Rails.application.routes.draw do

  namespace :admin do
    resources :site_changes, only: [:create, :update] do
      member do
        put :publish
      end
    end
    resources :preschools, only: [:index, :show] do
      resources :hours, only: [:create, :update, :destroy]
      resources :temp_hours, only: [:create, :destroy]
    end
    root to: 'preschools#index'
  end

  namespace :api do
    resources :preschools, only: [:index]
  end

  get 'position/:latitude,:longitude', to: 'home#index', latitude: /-?\d+\.\d+/, longitude: /-?\d+\.\d+/

  mount Sidekiq::Web => '/sidekiq'

  root to: 'home#index'
end
