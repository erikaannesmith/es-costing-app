Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#index"

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'
  namespace :user do
    resources :clients do
      get '/search', to: "style_search#index"
      resources :styles do
      end
    end
    resources :ship_notifications
    get '/search', to: "search#index"
  end

  

  

end
