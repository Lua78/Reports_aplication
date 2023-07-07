Rails.application.routes.draw do
  resources :categories, exept: :show
  namespace :authentication , path: '',as: '' do
    resources :users
  end
  resources:reports, path: '/'
end

