# encoding:utf-8
require "olleh-map/config"
require "addressable/uri"
require 'rest-client'
require 'json'
require 'uri'
module OllehMap
  class Geocode
    # http://kin.naver.com/qna/detail.nhn?d1id=6&dirId=6&docId=111021855&qb=7ZaJ7KCV64+Z&enc=utf8&section=kin&rank=4&search_sort=0&spq=0&sp=1
    ADDR_CD_TYPES = {
      'law'            => 0,
      'administration' => 1,
      'law_and_admin'  => 2,
      'road'           => 3
    }

    NEW_ADDR_TYPES = {
      'old'     => 0,
      'new'     => 1
    }

    INCLUDE_JIBUN = {
      'no'      => 0,
      'yes'     => 1
    }

    COORD_TYPES = {
      'utmk'    => 0,
      'tm_west' => 1,
      'tm_mid'  => 2,
      'tm_east' => 3,
      'katec'   => 4,
      'utm52'   => 5,
      'utm51'   => 6,
      'wgs84'   => 7,
      'bessel'  => 8
    }

    def self.addrcdtype
      ADDR_CD_TYPES
    end

    def self.new_addr_types
      NEW_ADDR_TYPES
    end

    def self.include_jibun
      INCLUDE_JIBUN
    end

    def self.geocode(options)
      json = JSON.generate({
        addr: URI.encode(options[:addr].strip).gsub('-', '%2D'),
        addrcdtype: self.addrcdtype[options[:addrcdtype]],
        timestamp: self.now
      })
      uri = URI.encode("https://openapi.kt.com/maps/geocode/GetGeocodeByAddr?params=#{json}").gsub(':','%3A').gsub(',','%2C').gsub('https%3A', 'https:')
      self.get_payload(uri)["RESDATA"]
    end

    def self.reverse_geocode(options)
      json = JSON.generate({
        x: options[:x],
        y: options[:y],
        addrcdtype: self.addrcdtype[options[:addrcdtype]],
        newAddr: self.new_addr_types[options[:new_addr_type]],
        isJibun: self.include_jibun[options[:include_jibun]],
        timestamp: self.now
      })
      uri = URI.encode("https://openapi.kt.com/maps/geocode/GetAddrByGeocode?params=#{json}").gsub(':','%3A').gsub(',','%2C').gsub('https%3A', 'https:')
      self.get_payload(uri)["RESDATA"]
    end



    def convert_coord()

    end

  private

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
