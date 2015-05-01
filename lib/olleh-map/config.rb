require "olleh-map/version"
require 'base64'
module OllehMap

  def self.token
    @token
  end

  def self.configure(id, pass)
    @token ||= Config.new(id, pass).get_auth
  end

  class Config
    @@auth_header = ""

    def initialize(id, pass)
      token = Base64.encode64("#{id}:#{pass}").strip
      @@auth_header = "Basic #{token}"
    end

    def get_auth
      @@auth_header
    end
  end
end
