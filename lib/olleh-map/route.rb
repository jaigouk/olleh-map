# encoding:utf-8
require "olleh-map/config"
require "olleh-map/util"
require "olleh-map/geocode"
require 'rest-client'
require 'json'
require 'uri'

module OllehMap
  class Route
    PRIORITY = {
      'shortest' => 0,
      'high_way' => 1,
      'free_way' => 2,
      'optimal'  => 3
    }

    def self.priority
      PRIORITY
    end

    def self.search(options)
      json = JSON.generate({
        SX: options[:start_x],
        SY: options[:start_y],
        EX: options[:end_x],
        EY: options[:end_y],
        RPTYPE: "0",
        COORDTYPE: Geocode.coord_types[options[:coord_type]],
        PRIORITY: self.priority[options[:priority]],
        timestamp:  Util.now
      })

      uri = URI.encode("https://openapi.kt.com/maps/etc/RouteSearch?params=#{json}").gsub(':','%3A').gsub(',','%2C').gsub('https%3A', 'https:')
      Util.get_payload(uri)["RESDATA"]["SROUTE"]["ROUTE"]
    end
  end
end
