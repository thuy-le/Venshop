VenShop::Application.routes.draw do


  resources :carts

  resources :users

  resources :products


  get 'welcome/index'
  get '/categories/:id' => 'categories#show'
  get  '/signup'   =>  'users#new'
  get  '/signin'   =>  'sessions#new'
  get  '/signout'  =>  'sessions#destroy'
  get  '/sessions' =>  'sessions#new'
  get  '/user/:id' =>  'users#show'
  post '/sessions' =>  'sessions#create'
  root             to: 'welcome#index'
  post '/user/create' => 'users#create'
  post '/user/update' => 'users#update'
  get  '/user/:id/edit' => 'users#edit'

end
