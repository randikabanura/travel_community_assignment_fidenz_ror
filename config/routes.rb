Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :users, controllers: { registrations: 'registrations' }
  authenticated :user do
    root to: 'welcome#index', as: :authenticated_root
  end
  root to: redirect('/users/sign_in')
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/profile//users/:id', to: 'profile#show', as: :profile_show
  mount Commontator::Engine => 'api/v1/commontator'
  get '/search', to: 'search#show', as: :search_show
  get '/messages', to: 'messages#index', as: :messages_home
  post '/message', to: 'messages#create', as: :message_create
  mount ActionCable.server, at: '/cable'

  namespace 'api' do
    namespace 'v1' do
      get '/users', to: 'users#index'
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
      post '/isfollowing', to: 'follows#isfollowing?'
      resources :reviews
      resources :user_reviews
    end
  end

  resources :trips do
    member do
      delete :delete_image_attachment
    end
  end

  resources :payments do
    member do
      put :extend_my_plan
    end
  end
end
