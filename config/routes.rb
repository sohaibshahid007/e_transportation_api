Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :e_transportations
      get '/count', to: 'e_transportations#count'
    end
  end
end
