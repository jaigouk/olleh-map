# OllehMap

1) tell us the distance of routing between two specific locations

2) distance calculation based on routes

3) need to handle lots of concurrent requests

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'olleh-map'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install olleh-map

## Usage: Route Search 

* Init

```
OllehMap.configure("OllehMapAPI0100","bncT89dfRT")
```

* route search

```
params = {
          start_x: "952715",
          start_y: "1950203",
          end_x: "954643",
          end_y: "1951419",
          coord_type: 'wgs84',
          priority: 'shortest'
        }
req = OllehMap::Route.search(params)
req["total_dist"].must_equal "2759"
req["total_time"].must_equal "5.55"

```

options for priority
```
'shortest', 'high_way', 'free_way', 'optimal' 
```

options for coord_type
```
'utmk', 'tm_west', 'tm_mid', 'tm_east', 'katec', 'utm52', 'utm51', 'wgs84', 'bessel'
```

## reference

https://github.com/rest-client/rest-client

http://devnote.tistory.com/199

https://github.com/JesseHerrick/minitest-with-shoulda/blob/master/test/test_calculator_basic.rb