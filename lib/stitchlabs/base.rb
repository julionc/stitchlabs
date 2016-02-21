require 'json'
require 'typhoeus'

module Stitchlabs
  class Base # :nodoc:
    def self.stitch_request(url, body)
      stitch_api_url = Stitchlabs.configuration.api_url
      stitch_endpoint_url = "#{stitch_api_url}/#{url}"
      # puts "URL: #{stitch_endpoint_url}"

      headers = {
        'access_token' => Stitchlabs.configuration.token,
        'Content-Type' => 'application/json;charset=UTF-8'
      }

      request = Typhoeus::Request.new(
        stitch_endpoint_url,
        method: :post,
        headers: headers,
        body: JSON.dump(body)
      )
      response = request.run
      response.response_body
    end
  end
end
