require 'net/http'
require 'json'

module LatestStockPrice
  class Client
    BASE_URL = 'https://latest-stock-price.p.rapidapi.com'.freeze
    API_KEY = 'd0a0c23ed5mshe586315faec938ap134569jsn554a0e8d5e4a'.freeze

    def initialize
      @headers = {
        'X-RapidAPI-Key' => API_KEY,
        'X-RapidAPI-Host' => 'latest-stock-price.p.rapidapi.com'
      }
    end

    def price(symbol)
      endpoint = "/price/#{symbol}"
      fetch_data(endpoint)
    end

    def prices(symbols)
      endpoint = "/prices/#{symbols.join(',')}"
      fetch_data(endpoint)
    end

    def price_all
      endpoint = '/any'
      fetch_data(endpoint)
    end

    private

    def fetch_data(endpoint)
      uri = URI("#{BASE_URL}#{endpoint}")
      request = Net::HTTP::Get.new(uri, @headers)

      response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
        http.request(request)
      end

      case response
      when Net::HTTPSuccess
        JSON.parse(response.body)
      else
        { error: 'Failed to fetch stock data' }
      end
    rescue StandardError => e
      { error: e.message }
    end
  end
end
