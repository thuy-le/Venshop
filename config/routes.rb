VenShop::Application.routes.draw do

  get  '/signup'   =>  'users#new'
  get  '/signin'   =>  'sessions#new'
  get  '/signout'  =>  'sessions#destroy'
  get  '/sessions' =>  'sessions#new'
  get  '/user/:id' =>  'users#show'
  post '/sessions' =>  'sessions#create'
  root             to: 'welcome#index'


end
