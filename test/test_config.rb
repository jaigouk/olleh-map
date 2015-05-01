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

end