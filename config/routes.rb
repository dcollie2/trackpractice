Rails.application.routes.draw do
  devise_for :users
  resources :practices
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "practices#index"
end
