Rails.application.routes.draw do
  resources :users, :attractions
  root 'application#home'
  get '/signin' => 'sessions#new'
  post '/signin' => 'sessions#create'
  post '/signout' => 'sessions#destroy'
  delete '/signout' => 'sessions#destroy'
  post '/rides/new' => 'attractions#ride'
end