# fluent-plugin-dynamodb-streams-alt

[![Gem Version](https://badge.fury.io/rb/fluent-plugin-dynamodb-streams-alt.svg)](http://badge.fury.io/rb/fluent-plugin-dynamodb-streams-alt)
[![Build Status](https://travis-ci.org/takus/fluent-plugin-dynamodb-streams-alt.svg?branch=master)](https://travis-ci.org/takus/fluent-plugin-dynamodb-streams-alt)
[![Test Coverage](https://codeclimate.com/github/takus/fluent-plugin-dynamodb-streams-alt/badges/coverage.svg)](https://codeclimate.com/github/takus/fluent-plugin-dynamodb-streams-alt/coverage)
[![Code Climate](https://codeclimate.com/github/takus/fluent-plugin-dynamodb-streams-alt/badges/gpa.svg)](https://codeclimate.com/github/takus/fluent-plugin-dynamodb-streams-alt)
[![Codacy Badge](https://api.codacy.com/project/badge/grade/a9fc76d35c8d4175bcb23e5c4b38fb85)](https://www.codacy.com/app/takus/fluent-plugin-dynamodb-streams-alt)

Fluentd input plugin for [AWS DynamoDB Streams](http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Streams.html).

Forked from [takus/fluent-plugin-dynamodb-streams](https://github.com/takus/fluent-plugin-dynamodb-streams); with fixes from [cosmo0920/fluent-plugin-dynamodb-streams](https://github.com/cosmo0920/fluent-plugin-dynamodb-streams)

## Preparation

Create IAM user with a policy like the following.

```
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "dynamodb:GetRecords",
        "dynamodb:GetShardIterator",
        "dynamodb:DescribeStream",
        "dynamodb:ListStreams"
      ],
      "Resource": "*"
    }
  ]
}
```

Or define `aws_key_id` and `aws_sec_key` in your config file.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fluent-plugin-dynamodb-streams-alt'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fluent-plugin-dynamodb-streams-alt

## Configuration

```apache
<source>
  type dynamodb_streams
  #aws_key_id  AWS_ACCESS_KEY_ID
  #aws_sec_key AWS_SECRET_ACCESS_KEY
  #aws_region  AWS_DEFAULT_REGION
  stream_arn arn:aws:dynamodb:ap-northeast-1:000000000000:table/table_name/stream/2015-01-01T00:00:00.000
  pos_file /var/lib/fluent/dynamodb_streams_table_name
  fetch_interval 1
  fetch_size 1
</source>
```

- `tag`: Fluentd tag.
- `stream_arn`: DynamoDB Streams ARN.
- `pos_file`: File to store last sequence number.
- `fetch_interval`: The interval to fetch records in seconds. Default is 1 sec.
- `fetch_size`: The maximum number of records fetches in each iteration. Default is 1.

## Output

```javascript
{
  "aws_region": "ap-northeast-1",
  "event_source": "aws:dynamodb",
  "event_version": "1.0",
  "event_id": "dfbdf4fe-6f2b-4b34-9b17-4b8caae561fa",
  "event_name": "INSERT",
  "dynamodb": {
    "stream_view_type": "NEW_AND_OLD_IMAGES",
    "sequence_number": "000000000000000000001",
    "size_bytes": 14,
    "keys": {
      "key": "value2"
    },
    "old_image": {
      "key": "value1"
    },
    "new_image": {
      "key": "value2"
    }
  }
}
```

## TODO

- store sequence number to DynamoDB
- fetch records from each shards concurrently
