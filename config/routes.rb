Rails.application.routes.draw do
  resources :foci
  resources :pages
  devise_for :users
  resources :practices
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "pages#home"
end
