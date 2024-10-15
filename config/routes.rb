Rails.application.routes.draw do
  resources :transactions, only: [:create]
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'latest_stock_price/price/:symbol', to: 'stock_prices#price'
  get 'latest_stock_price/prices', to: 'stock_prices#prices'
  get 'latest_stock_price/price_all', to: 'stock_prices#price_all'
end
