Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "articles#index"
  resources :articles do
    resources :comments
  end
  # get "articles", to: "articles#index"
  # get "articles/:id", to: "articles#show"

  match '/auth/saml/:identity_provider_id/callback',
        via: [:get, :post],
        to: 'articles#saml_callback',
        as: 'user_omniauth_callback'

  # match '/auth/saml/:identity_provider_id',
  #       via: [:get, :post],
  #       to: 'articles#passthru',
  #       as: 'user_omniauth_authorize'
end