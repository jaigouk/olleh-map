require 'minitest_helper'

describe OllehMap do
  describe OllehMap::Config do
    it "should have not be nil" do
      ::OllehMap::VERSION.wont_be_nil
    end

    it "should be configurable"  do
      OllehMap.configure("OllehMapAPI0100","bncT89dfRT")
      OllehMap.token.must_equal "Basic T2xsZWhNYXBBUEkwMTAwOmJuY1Q4OWRmUlQ="
    end
  end

  describe OllehMap::Geocode do

    before do
      OllehMap.configure("OllehMapAPI0100","bncT89dfRT")
    end

    describe '#reverse_geocode' do
      it "should reverse geocode(coord -> addr)" do
        params = {
          x: "1815743",
          y: "993479",
          addrcdtype: 'law',
          new_addr_type: 'old',
          include_jibun: 'yes'
        }
        req = OllehMap::Geocode.reverse_geocode(params)
        req["ADDRS"].first["ADDRESS"].must_equal "경상남도 진주시 수곡면 원계리 763-2"
      end
    end

    describe '#geocode' do
      it "should geocode (addr -> coord)" do
        params = {
          addr: "서울특별시 강남구 삼성동 168-1",
          addrcdtype: 'law'
        }
        req = OllehMap::Geocode.geocode(params)
        req["ADDRS"].first["X"].must_equal 961376
        req["ADDRS"].first["Y"].must_equal 1945766
      end
    end

    # it "should return routes with starting and ending addresses" do
    # end

    # it "should return routes with starting and ending addresses" do
    # end

    # it "should return distance in routes"
    # it "should have sorted distances in routes search result"
    # it "tells us the distance of routing between two specific locations"
  end
end