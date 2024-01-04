Rails.application.routes.draw do
  get 'analytics/index'
  get 'search', to: 'search#search'
  resources :articles
  resources :analytics
  root 'search#search'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
