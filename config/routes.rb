Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
  
  root 'api/v1/gardens#index'

  namespace :api do
    namespace :v1 do
      resources :recommendation, only: [:index]
      resources :gardens, only: [:index, :show, :create, :update]  
      patch ':garden_id', to: 'garden_plants#update'
      delete '/gardens/:garden_id/plants/:plant_id', to: 'garden_plants#destroy'
      get ':garden_id/plants', to: 'garden_plants#show'
      get 'api/v1/gardens', to: 'gardens#index'
    end
  end
end
