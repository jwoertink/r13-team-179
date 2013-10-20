Datingscene::Application.routes.draw do
  namespace :admin do
    root 'questions#new'
    resources :questions
  end
  
  root 'site#index'
  get '/privacy-policy' => 'site#privacy', as: :privacy
  get '/terms-of-service' => 'site#terms', as: :terms
  get '/s/:key' => 'profiles#show', as: :scene
  
  resources :profiles, only: [:create]
  
  # Error Pages
  get '/404', :to => 'errors#not_found'
  get '/422', :to => 'errors#unprocessable_entity'
  get '/500', :to => 'errors#internal_server_error'
end
