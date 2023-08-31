Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post '/users/create', to: 'users#create'
  post '/users/login', to: 'users#login'
  get '/users/:id', to: 'users#get_user'
  post '/calculation', to: 'calculator#calculate'
end
