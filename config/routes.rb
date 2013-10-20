Datingscene::Application.routes.draw do
  namespace :admin do
    root 'questions#new'
    resources :questions, only: [:index, :new, :create]
  end
  
  root 'site#index'
  get '/privacy-policy' => 'site#privacy', as: :privacy
  get '/terms-of-service' => 'site#terms', as: :terms
  get '/s/:key' => 'scenes#show', as: :scene
  
  # Error Pages
  get '/404', :to => 'errors#not_found'
  get '/422', :to => 'errors#unprocessable_entity'
  get '/500', :to => 'errors#internal_server_error'
end
