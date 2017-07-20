Rails.application.routes.draw do
  root to: "members#index"

  # HomeController
  resources :home, only: :index
  resources :members
  resources :transactions
end
