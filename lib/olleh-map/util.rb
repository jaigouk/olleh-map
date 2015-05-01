# encoding:utf-8
require "olleh-map/config"
require 'rest-client'
require 'json'
require 'uri'
module OllehMap
  class Util

    def self.now
      Time.now.strftime("%Y%m%d%H%M%S%L")
    end

    def self.get_payload(uri)
      request = RestClient.get(uri, {:Authorization => OllehMap.token, :accept => :json})
      result =  JSON.parse(request)
      res_data = JSON.parse(URI.decode(result["payload"]).gsub('+',' '))
    end

  end
end
