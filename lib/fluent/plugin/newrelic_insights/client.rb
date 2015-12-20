require 'rest-client'
require 'json'

module Fluent::NewrelicInsights
  class Client
    def initialize(account_id, insert_key)
      @account_id = account_id
      @insert_key = insert_key
      @url = "https://insights-collector.newrelic.com/v1/accounts/#{account_id}/events"
    end

    def insert_events(events)
      response = RestClient::Request.execute(
        method: :post,
        url: @url,
        payload: events.to_json,
        headers: {
          "Content-Type" => "application/json",
          "X-Insert-Key" => @insert_key
        }
      )
      JSON.load(response.to_s)
    end
  end
end
