require 'json'

module Stitchlabs
  class PackingSlip < Stitchlabs::Base # :nodoc:
    def initialize(params = [])
      body = {
        action: 'write',
        'PackingSlips' => [{
          'packing_slip_date': params[:my_date],
          'notes': 'notes go here',
          'links': {
            'Addresses' => [{ id: params[:address_id] }],
            'Contacts' => [{ id: params[:contact_id] }],
            'LineItems' => [
              {
                id: params[:line_item_id],
                quantity: params[:line_item_quantity],
                order_sku_id: params[:line_order_sku_id]
              }
            ],
            'SalesOrders' => [{ id: params[:sales_order_id] }]
          }
        }]
      }
      @response = Base::stitch_request('api2/v1/PackingSlips', body)

      data = JSON.parse(@response)
      exist_data = data['PackingSlips'].count
      return nil if exist_data == 0
      data['PackingSlips'].first['id']
    end # initialize
  end

  def get_detail_by_id(packing_slip_id)
  end # get_detail_by_id
end
