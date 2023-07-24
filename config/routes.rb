Rails.application.routes.draw do
  resources :categories, exept: :show

  namespace :authentication , path: '',as: '' do
    resources :users
    resources :sessions,path:'login', only: [ :create, :new, :destroy] 
  end

  resources:reports, path: '/'
end

