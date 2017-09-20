Rails.application.routes.draw do

  namespace :admin do
    resources :site_changes, only: [:create, :update] do
      member do
        put :publish
      end
    end
    resources :preschools, only: [:index, :show] do
      resources :hours, only: [:create, :update, :destroy]
    end
    root to: 'preschools#index'
  end

  get 'position/:latitude,:longitude', to: 'home#index', latitude: /-?\d+\.\d+/, longitude: /-?\d+\.\d+/

  root to: 'home#index'
end
