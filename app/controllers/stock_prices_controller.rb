class StockPricesController < ApplicationController
  def price
    symbol = params[:symbol]
    stock_price_service = LatestStockPrice::Client.new
    price_data = stock_price_service.price(symbol)

    render json: {
      message: 'Stock price retrieved successfully',
      stock_price: price_data
    }, status: :ok
  rescue StandardError => e
    render json: { error: e.message }, status: 500
  end

  def prices
    symbols = params[:symbols].split(',')
    stock_price_service = LatestStockPrice::Client.new
    prices_data = stock_price_service.prices(symbols)

    render json: {
      message: 'Stock prices retrieved successfully',
      stock_prices: prices_data
    }, status: :ok
  rescue StandardError => e
    render json: { error: e.message }, status: 500
  end

  def price_all
    stock_price_service = LatestStockPrice::Client.new
    prices_data = stock_price_service.price_all

    render json: {
      message: 'All stock prices retrieved successfully',
      stock_prices: prices_data
    }, status: :ok
  rescue StandardError => e
    render json: { error: e.message }, status: 500
  end
end
