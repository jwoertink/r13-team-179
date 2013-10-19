Datingscene::Application.routes.draw do
  
  root 'site#index'
  get '/privacy-policy' => 'site#privacy', as: :privacy
  get '/terms-of-service' => 'site#terms', as: :terms
end
