Rails.application.routes.draw do
  resources :events do
    resources :tickets
  end

  root 'welcome#index'

  get '/auth/:provider/callback' => 'sessions#create'
  get '/logout' => 'sessions#destroy', as: :logout
end
