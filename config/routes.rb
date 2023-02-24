Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :activities, only: [:index]
      resources :users, only: [:create, :update] do 
        resources :ferns, only: [:index, :show, :create, :update, :destroy], controller: "users/ferns"
        resources :shelves, only: [:create, :update, :destroy], controller: "users/shelves"
      end
    end
  end
end
