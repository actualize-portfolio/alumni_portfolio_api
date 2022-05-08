# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  get '/health_check', to: proc { [200, {}, ['success']] }

  mount ActionCable.server => '/cable'
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  mount Sidekiq::Web, at: '/sidekiq'

  namespace :api do
    namespace :v1 do
      post '/login', to: 'sessions#login'

      resources :books, only: [:index]
      resources :concerts, only: %i[index show]
      resources :favorites, only: %i[create]
      resources :funny_bot_messages, only: [:create]
      resources :github_repos, only: [:index]
      resources :movies, only: [:index]
      resources :service_web_resources, only: %i[index show]
      resources :sunny_episodes, only: [:index]
      resources :sunny_episode_user_rankings, only: %i[index create]
      resources :user_books, only: %i[create destroy]
      resources :users, only: %i[show create update]
    end
  end
end
