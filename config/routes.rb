Rails.application.routes.draw do
  root to: 'products#index' # And remove the generated route `products/index`
  devise_for :users
  resources :products, only: [:new, :create]
end
