Rails.application.routes.draw do
  resources :products do
    collection do
      get :awesomplete_product_name
    end
  end
  root to: 'products#index'
end
