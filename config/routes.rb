Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'
  get '/profile//users/:id', to: "profile#show"
  namespace 'api' do
    namespace 'v1' do
      get '/users', to: "users#index"
      resources :users, only: [:show] do
        member do
          delete :delete_image_attachment
          get :avatar_image_thumbnail
        end
      end
      resources :follows, only: [:index, :new, :create, :destroy] do
        member do
          get :allfollowers
          get :allfollowing
        end
      end
      post '/isfollowing', to: "follows#isfollowing?"
    end
  end
end
