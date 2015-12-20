# Fluentd output plugin for New Relic Insights

## Installation

```ruby
gem 'fluentd'
gem 'fluent-newrelic-insights'
```

## Configuration

### Account ID and Insert Key

`account_id` and `insert_key` are required.

```
<match **>
  @type newrelic_insights
  account_id <Your Account ID>
  insert_key <Your Insert Key>
</match>
```

### Event Type Key

You can specify `event_type_key` attribute which is used for Insights' `eventType`. The default value is `eventType`

```
<match **>
  @type newrelic_insights
  account_id <Your Account ID>
  insert_key <Your Insert Key>
  event_type_key event
</match>
```

### Event Data Key

```
<match **>
  @type newrelic_insights
  account_id <Your Account ID>
  insert_key <Your Insert Key>
  event_type_key event
  event_data_key eventData
</match>
```

`event_data_key` attribute is used to specify the root event data object. The default value is `.` which sends an entire log data to Insights. For example, if you set it to `eventData` and you get the following log data:

```
{
  "eventType": "Purchase",
  "foo": "bar",
  "eventData": {
    "amount": 1000,
    "product_id": 123
  }
}
```

the below data will be sent to Insights'

```
{
  "eventType": "Purchase",
  "amount": 1000,
  "product_id": 123
}
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/k2nr/fluent-newrelic-insights.
