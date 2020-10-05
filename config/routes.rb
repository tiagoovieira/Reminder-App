Rails.application.routes.draw do
  devise_for :users
  resources :reminders
  root :to => "home#index"
end
