NoTeLimites::Application.routes.draw do

  root to: 'home#home'
  match '/terminos',    to: 'info#terminos',    via: 'get'
  match '/analytics',    to: 'info#analytics',    via: 'get'
  get '/robots.:format' => 'info#robots'
  devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks", registrations: 'devise/registrations' }
  match '/users/auth/facebook' => 'devise/omniauth_callbacks#passthru',  via: 'get'
  match 'auth/:provider/callback', to: 'sessions#create',   via: 'get'
  match 'auth/failure', to: redirect('/'),                  via: 'get'
  match '/users/sign_out',    to: 'devise/sessions#destroy',    via: 'post'
  get '/faq/' => redirect( "/", status:301)
  get 'search' => 'search#index', as: :search

  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :events, :path => 'eventos' do
    member do
      get :following, :followers
    end
  end

  get '/events/' => redirect( "/eventos/", status:301)
  get '/events/(/*path)' => redirect {|params| "/eventos/#{Event.friendly.find(params[:path]).to_param}"},  status:301

  resources :venues do
    member do
      get :following, :followers
    end
  end

  get '/micrositios/' => redirect( "/venues/", status:301)
  get '/micrositios/(/*path)' => redirect {|params| "/venues/#{Venue.friendly.find(params[:path]).to_param}"},  status:301

  resources :agencies, :path => 'agencias'
  resources :locations
  resources :categories, :path => 'categorias'
  resources :suppliers
  resources :relationships, only: [:create, :destroy]
  resources :relationevents, only: [:create, :destroy]
  resources :relationvenues, only: [:create, :destroy]
  resources :images

  constraints subdomain: 'api' do
    namespace :api, path: '/', defaults: {format: 'json'} do
      devise_scope :user do
        get 'sign_in', to: 'sessions#new'
        get 'sign_out', to: 'sessions#destroy'
      end
      namespace :v101 do
        resources :users,               only: [:show, :index, :create]
        resources :agencies,            only: [:show, :index]
        resources :categories,          only: [:show, :index]
        resources :suppliers,           only: [:show, :index]
        resources :events,              only: [:show, :index]
        resources :locations,           only: [:show, :index, :create]
        resources :venues,              only: [:show, :index]
        match '/relationevents', to: 'relationevents#relations', via: 'get'
        match '/relationevents', to: 'relationevents#destroy',  via: 'delete'
        match '/relationships',  to: 'relationships#relations',  via: 'get'
        match '/relationships',  to: 'relationships#destroy',  via: 'delete'
        match '/relationvenues', to: 'relationvenues#relations', via: 'get'
        match '/relationvenues', to: 'relationvenues#destroy', via: 'delete'
        resources :relationevents,      only: [:create, :destroy]
        resources :relationships,       only: [:create, :destroy]
        resources :relationvenues,      only: [:create, :destroy]
        match '/search', to: 'search#index', as: :search, via: 'get'
      end
    end
  end

end
