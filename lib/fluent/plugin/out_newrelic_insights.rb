require "fluent/plugin/newrelic_insights"
require 'json'

module Fluent
  class NewrelicInsightsOutput < BufferedOutput
    Fluent::Plugin.register_output('newrelic_insights', self)

    config_set_default :buffer_chunk_records_limit, 1000
    config_set_default :buffer_chunk_limit, 5 * 1024 * 1024
    config_set_default :flush_interval, 10

    config_param :account_id, :string
    config_param :insert_key, :string
    config_param :event_type_key, :string, default: 'eventType'
    config_param :event_data_key, :string, default: '.'

    def configure(conf)
      super
    end

    def start
      super
      @client = Fluent::NewrelicInsights::Client.new(@account_id, @insert_key)
    end

    def shutdown
      super
    end

    def format(tag, time, record)
      [tag, time, record].to_msgpack
    end

    def write(chunk)
      events = []
      chunk.msgpack_each do |tag, time, record|
        event = build_event(tag, time, record)
        next if event.nil?
        events << event
      end
      @client.insert_events(events)
    end

    def build_event(tag, time, record)
      type = record[@event_type_key]
      return nil unless type
      data = @event_data_key == '.' ? record : record[@event_data_key]
      data ||= {}
      return nil unless data.is_a?(Hash)
      data = flatten_hash(data)
      data.merge! "eventType" => type, "fluentTag" => tag, "timestamp" => time.to_i
    end

    def flatten_hash(hash, prefix='', base=hash, flattened={})
      hash.keys.each do |k|
        if hash[k].is_a? Hash
          flatten_hash(hash[k], "#{prefix}#{k}.", base, flattened)
        else
          flattened["#{prefix}#{k}"] = hash[k]
        end
      end
      flattened
    end
  end
end
