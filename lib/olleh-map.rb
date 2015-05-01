# encoding:utf-8

require "olleh-map/version"
require 'base64'
require "addressable/uri"
require 'rest-client'
require 'json'
require 'uri'
module OllehMap
  class Search
    def initialize(id, pass)
      @token = Base64.encode64("#{id}:#{pass}").strip
      @auth_header = "Basic #{@token}"
    end

    def token
      @token
    end


    def geocode(addr, addr_type)
      now = Time.now.strftime("%Y%m%d%H%M%S%L")
      params = JSON.generate({addr: addr, addrcdtype: addr_type.to_s, timestamp: now})
      uri = Addressable::URI.parse("https://openapi.kt.com/maps/geocode/GetGeocodeByAddr?params=#{params}").normalize.to_s
      request = RestClient.get(uri, {:Authorization => @auth_header, :accept => :json})
      result =  JSON.parse(request)
      res_data = JSON.parse(URI.decode(result["payload"]))
      res_data
    end



    def reverse_geocode(x,y, addr_type=0, newAddr=0, isJibun=1)
      now = Time.now.strftime("%Y%m%d%H%M%S%L")
      params = JSON.generate({
        x: x,
        y: y,
        addrcdtype: addr_type.to_s,
        newAddr: newAddr.to_s,
        isJibun: isJibun.to_s,
        timestamp: now})
      uri = Addressable::URI.parse("https://openapi.kt.com/maps/geocode/GetAddrByGeocode?params=#{params}").normalize.to_s
      request = RestClient.get(uri, {:Authorization => @auth_header, :accept => :json})
      result =  JSON.parse(request)
      res_data = JSON.parse(URI.decode(result["payload"]).gsub('+',' '))
      res_data["RESDATA"]
    end


  end
end
