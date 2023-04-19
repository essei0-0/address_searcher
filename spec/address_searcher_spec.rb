# frozen_string_literal: true

RSpec.describe AddressSearcher do
  it "has a version number" do
    expect(AddressSearcher::VERSION).not_to be nil
  end

  it "search_address" do
    expect(AddressSearcher.search_address("1000001")).to eq({
      "status" => 200,
      "message" => nil,
      "results" => [
        {
          "zipcode" => "1000001",
          "address1" => "東京都",
          "address2" => "千代田区",
          "address3" => "千代田",
          "kana1" => "ﾄｳｷｮｳﾄ",
          "kana2" => "ﾁﾖﾀﾞｸ",
          "kana3" => "ﾁﾖﾀﾞ",
          "prefcode" => "13",
        }
      ]
    })
  end

  it "search_address_with_full_address" do
    expect(AddressSearcher.search_address("1000001", full_address: true)).to eq({
      "status" => 200,
      "message" => nil,
      "results" => [
        {
          "zipcode" => "1000001",
          "address1" => "東京都",
          "address2" => "千代田区",
          "address3" => "千代田",
          "kana1" => "ﾄｳｷｮｳﾄ",
          "kana2" => "ﾁﾖﾀﾞｸ",
          "kana3" => "ﾁﾖﾀﾞ",
          "prefcode" => "13",
          "full_address" => "東京都千代田区千代田",
          "full_kana" => "ﾄｳｷｮｳﾄﾁﾖﾀﾞｸﾁﾖﾀﾞ"
        }
      ]
    })
  end
end

