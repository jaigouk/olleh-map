require 'minitest_helper'

describe OllehMap do

  describe OllehMap::Route do

    before do
      VCR.insert_cassette name
      OllehMap.configure("OllehMapAPI0100","bncT89dfRT")
    end

    after do
      VCR.eject_cassette
    end

    describe '#search' do
      it "should return distance in routes" do
        VCR.use_cassette('search', :record => :new_episodes) do
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
          req["total_time"].must_equal "7.09"
        end
      end
    end

    # it "should return routes with starting and ending addresses" do
    # end

    # it "should return routes with starting and ending addresses" do
    # end


    # it "should have sorted distances in routes search result"
    # it "tells us the distance of routing between two specific locations"
  end
end