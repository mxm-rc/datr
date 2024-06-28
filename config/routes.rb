Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  root to: "pages#landing_page"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get '/friends' => "friends#index", :as => :user_root

  resources :friends, only: %i[index show] do
    resources :meets, only: %i[index new create] do
      resources :selected_places, only: %i[index create show]
    end
  end

  resources :users, only: %i[show edit update index] do
    resources :accointances, only: %i[index create show]
    resources :meets, only: %i[index]
  end
  resources :accointances, only: %i[index]
  resources :meets, only: %i[index]

  resources :accointances_requests, only: %i[index]
  resources :accointances_requests, path: "accointances_requests/:status", only: %i[update]


  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
end
