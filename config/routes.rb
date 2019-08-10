Rails.application.routes.draw do

  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
    registrations: 'auth/registrations'
  }

  resources :words do
    get "count", on: :collection
    get "search", on: :collection
  end
  # get 'words/search', to: 'words#search'
  resources :languages
  resources :words_with_languages
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :auth do
    get 'user' => 'users#show'
  end

end
