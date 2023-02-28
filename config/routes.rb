Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :activities, only: [:index]
      resources :users, only: [:create, :update] do 
        resources :ferns, controller: "users/ferns"
        resources :shelves, only: [:index, :create, :update, :destroy], controller: "users/shelves"
      end
    end
  end

  get '/reset_seeds', to: 'application#reset_seeds'
end
