Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get '/friends' => "friends#index", :as => :user_root

  resources :friends, only: %i[index show] do
    resources :meets, only: %i[new create] do
      resources :selected_places, only: %i[index create show]
    end
  end

  resources :friends, only: %i[index show]
  resources :users do
    resources :accointances, only: %i[index create show]
    resources :meets, only: %i[index]
  end
  resources :accointances, only: %i[index]

  resources :accointances_requests, only: %i[index] do
    member do
      post 'approve'
      post 'deny'
    end
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
