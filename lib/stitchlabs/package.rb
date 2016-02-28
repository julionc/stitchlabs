require 'json'

module Stitchlabs
  class Package < Stitchlabs::Base # :nodoc:

    attr_accessor :packing_slips, :package_carrier_type, :sales_order
    attr_accessor :ship_date, :notes, :tracking_link, :tracking_number
    attr_accessor :cost, :delivered, :id

    def save
      body = {
        action: 'write',
        'Packages' => [{
          ship_date: @ship_date,
          notes: @notes,
          tracking_link: @tracking_link,
          tracking_number: @tracking_number.to_s,
          cost: @cost,
          delivered: @delivered,
          'links' => {
            'PackingSlips' => [{ id: @packing_slips.to_s }],
            'PackageCarrierTypes' => [{ id: @package_carrier_type.to_s }],
            'SalesOrders' => [{ id: @sales_order.to_s }]
          }
        }]
      }

      @response = Base::stitch_request('api2/v1/Packages', body)

      data = JSON.parse(@response)
      exist_data = data['Packages'].count
      return nil if exist_data == 0
      @id = data['Packages'].first['id'].to_i
    end
  end
end
