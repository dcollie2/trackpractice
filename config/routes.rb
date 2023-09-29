Rails.application.routes.draw do
  resources :songs
  resources :foci
  resources :pages
  devise_for :users
  resources :users, except: [:create, :new] do
    resources :practices, only: [:index]
  end
  resources :practices
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "practices#index"
end
