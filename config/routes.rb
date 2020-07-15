Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get '/merchants/most_revenue', to: 'merchant_revenues#index'
      get '/merchants/most_items', to: 'merchant_items#index'
      resources :items, except: [:new, :edit] do
        get '/merchant', to: 'merchants#show'
      end
      resources :merchants, except: [:new, :edit] do
        get '/items', to: 'items#index'
        get '/revenue', to: 'merchant_revenues#show'
      end
    end
  end
end
