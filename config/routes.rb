Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  root to: "pages#landing_page"

  get '/friends' => "friends#index", as: :user_root

  resources :friends, only: %i[index show] do
    resources :meets, only: %i[index new create] do
      resources :selected_places, only: %i[index create show]
    end
  end

  resources :users, only: %i[show edit update] do
    resources :accointances, only: %i[index create show]
    resources :meets, only: %i[index]
  end
  resources :accointances, only: %i[index]
  resources :meets, only: %i[index]

  resources :accointances_requests, only: %i[index update] do
    member do
      post 'approve'
      post 'deny'
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
