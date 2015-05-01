require 'minitest_helper'

describe OllehMap do
  describe OllehMap::Geocode do

    before do
      VCR.insert_cassette name
      OllehMap.configure("OllehMapAPI0100","bncT89dfRT")
    end

    after do
      VCR.eject_cassette
    end

    describe '#geocode' do
      it "should geocode (addr -> coord)" do
        VCR.use_cassette('geocode', :record => :new_episodes) do
          params = {
          addr: "서울특별시 강남구 삼성동 168-1",
          addrcdtype: 'law'
        }
          req = OllehMap::Geocode.geocode(params)
          req["ADDRS"].first["X"].must_equal 961376
          req["ADDRS"].first["Y"].must_equal 1945766
        end
      end
    end

    describe '#reverse_geocode' do
      it "should reverse geocode(coord -> addr)" do
        VCR.use_cassette('reverse_geocode', :record => :new_episodes) do
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
    end

    describe '#convert_coord' do
      it "should convert points to a specific coord type" do
        VCR.use_cassette('convert_coord', :record => :new_episodes) do
          params = {
            x: '951203',
            y: '1950435',
            coord_in: 'utmk',
            coord_out: 'wgs84'
          }
          req = OllehMap::Geocode.convert_coord(params)
          req["COORDTYPE"].must_equal "LLW"
          req["Y"].must_equal "37.551966221235176"
          req["X"].must_equal "126.9475548915227"
        end
      end
    end


  end
end