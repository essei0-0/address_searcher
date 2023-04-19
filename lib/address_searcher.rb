# frozen_string_literal: true

require_relative "address_searcher/version"
require 'net/http'
require 'uri'
require 'json'

module AddressSearcher
  def self.search_address(zipcode, full_address: false)
    url = URI.parse("https://zip-cloud.appspot.com/api/search?zipcode=#{zipcode}")
    
    response = Net::HTTP.get_response(url)
    if response.is_a?(Net::HTTPSuccess)
      # レスポンスが正常な場合の処理
      body = response.body
      hash = JSON.parse(body)

      puts body
      if full_address
        puts hash["results"]
        hash["results"].each do |result|
          full_address = "#{result["address1"]}#{result["address2"]}#{result["address3"]}"
          full_kana = "#{result["kana1"]}#{result["kana2"]}#{result["kana3"]}"

          result["full_address"] = full_address
          result["full_kana"] = full_kana
        end
      end
      
      hash
    else
      raise "エラーが発生しました。status: #{response.code}, message: #{response.message}"
    end
  end
end