require 'json'

module Stitchlabs
  class SalesOrder < Stitchlabs::Base # :nodoc:

    class << self
      attr_accessor :sales_order, :addresses, :contacts, :line_items
    end

    def self.open_sales_orders_ids
      body = {
        action: 'read',
        page_size: 50,
        page_num: 1,
        filter: {
          and: [
            { archived:  0 },
            { status_invoice: 3 },      # Bill - Import from Shopify
            { status_payment: 3 },      # Pay - Sale Order is marked as paid
            # { status_packing_slip: 1 },
            { status_package: 0 },
            { status_deliver: 0 }
          ]
        },
        sort: [{
          order_date: 'desc'
        }]
      }

      @response = Base::stitch_request('api2/v2/SalesOrders', body)

      data = JSON.parse(@response)
      exist_data = data['SalesOrders'].count
      return nil if exist_data == 0

      sales_orders = data['SalesOrders']
      sales_orders_ids = sales_orders.map { |order| order['id'] }
      sales_orders_ids
    end # get_open_sales_orders_ids

    def self.find_by_id(sales_order_id)
      body = {
        action: 'read',
        'SalesOrders' => [
          {
            id: sales_order_id
          }
        ]
      }

      @response = Base::stitch_request('api2/v2/SalesOrders/detail', body)

      data = JSON.parse(@response)
      exist_data = data['SalesOrders'].count

      return nil if exist_data == 0

      @addresses = data['Addresses']
      @contacts = data['Contacts']
      @line_items = data['SalesOrderLineItems']
      @sales_order = data['SalesOrders']
      data
    end # find_by
  end
end
