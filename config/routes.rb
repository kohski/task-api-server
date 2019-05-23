Rails.application.routes.draw do
  get 'posts/create'
  get 'posts/index'
  root to: "tasks#index"

  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
    registrations: 'auth/registrations'
  }

  namespace :api do
    namespace :v1 do
      resources :tasks
    end
  end

  namespace :api do
    namespace :v1 do
      resources :posts
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
