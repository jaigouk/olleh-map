require 'minitest_helper'

describe OllehMap::Search do
  it "should have not be nil" do
    ::OllehMap::VERSION.wont_be_nil
  end

  it "should be configurable - api key, etc"  do
    s = OllehMap::Search.new("OllehMapAPI0100","bncT89dfRT")
    s.token.must_equal "T2xsZWhNYXBBUEkwMTAwOmJuY1Q4OWRmUlQ="
  end

  it "should reverse geocode(coord -> addr)" do
    s = OllehMap::Search.new("OllehMapAPI0100","bncT89dfRT")
    x = "1815743"
    y = "993479"
    req = s.reverse_geocode(x,y)
    req["ADDRS"].first["ADDRESS"].must_equal "경상남도 진주시 수곡면 원계리 763-2"
  end

  it "should geocode (addr -> coord)" do
    s = OllehMap::Search.new("OllehMapAPI0100","bncT89dfRT")
    addr = "삼성동"
    req = s.geocode(addr, 0)
    req["ERRMS"].must_equal 'SUCCESS'
  end


  # it "should return routes with starting and ending addresses"
  # it "should return distance in routes"
  # it "should have sorted distances in routes search result"
  # it "tells us the distance of routing between two specific locations"

end