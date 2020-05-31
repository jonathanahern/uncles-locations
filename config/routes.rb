Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'front_end/index'
    end
  end
  mount ShopifyApp::Engine, at: '/'
# frozen_string_literal: true

namespace :app_proxy do
  root action: 'index'
  # simple routes without a specified controller will go to AppProxyController

  # more complex routes will go to controllers in the AppProxy namespace
  #   resources :reviews
  # GET /app_proxy/reviews will now be routed to
  # AppProxy::ReviewsController#index, for example
end

  root to: 'api/v1/home#index'
  
  namespace :api do
    namespace :v1 do
      get 'home/index'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
