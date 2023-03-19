Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :activities, only: :index
      resources :users, only: %i[create update] do
        resources :ferns, controller: 'users/ferns' do
          resources :stats, controller: 'users/ferns/stats', only: :index
        end
        resources :shelves, only: %i[index create update destroy], controller: 'users/shelves'
      end
    end
  end
end
