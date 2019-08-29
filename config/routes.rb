Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  namespace 'api' do
    namespace 'v1' do
      get '/users', to: "users#index"
      resources :users, only: [:show]
      resources :follows, only: [:index, :new,:create, :destroy]
      post '/isfollowing', to: "follows#isfollowing?"
    end
  end
end
