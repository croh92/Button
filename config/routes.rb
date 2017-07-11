Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'application#index'
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get '/search/twitter/user/:handle', to: 'application#search_by_user'
  get '/search/twitter/hashtag/:hashtag', to: 'application#search_by_hashtag'
  get '/search/twitter/date/:key', to: 'application#search_by_date'
end
