Rails.application.routes.draw do
  # Devise routes for email/password login and registration
  devise_for :users, controllers: {
    sessions: "devise/sessions",
    registrations: "devise/registrations",
    confirmations: "devise/confirmations",
    omniauth_callbacks: "users/omniauth_callbacks"
  }, path: "", path_names: {
    sign_in: "sign_in", sign_out: "sign_out", sign_up: "sign_up"
  }

  # OAuth login for Spotify
  devise_scope :user do
    get "users/auth/spotify", to: "users/omniauth_callbacks#passthru", as: :new_user_spotify_session
  end

  resources :tasks
  resources :journals do
    collection do
      get "new_detail" # 日記の詳細作成ページへのルートを追加
    end
  end

  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check

  # PWA routes
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  get "introduce", to: "introduce#index", as: :introduce
  get "search_song", to: "journals#search_song"

  # Root path
  root to: "static_pages#top"
end
