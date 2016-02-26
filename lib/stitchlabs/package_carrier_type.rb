require 'json'

module Stitchlabs
  class PackageCarrierType < Stitchlabs::Base # :nodoc:
    def self.all
      body = { action: 'read' }
      @response = Base::stitch_request('api2/v2/2/PackageCarrierTypes', body)
      data = JSON.parse(@response)
      data['PackageCarrierTypes']
    end

    def self.find(carrier_name)
      body = { action: 'read' }
      @response = Base::stitch_request('api2/v2/2/PackageCarrierTypes', body)
      json_data = JSON.parse(@response)
      data = json_data['PackageCarrierTypes']
      carrier_type = data.select { |item| item['name'] == carrier_name }.first
      return nil if carrier_type.size == 0
      carrier_type
    end
  end
end
