require 'json'

module Stitchlabs

  class SalesOrder < Stitchlabs::Base

    def self.get_open_sales_orders_ids(page_num=1)
      @page_size = 50
      @page_num = page_num || 1

      body = {
        "action" => "read",
        "page_size" => @page_size,
        "page_num" => @page_num,
        "filter" => {
          "and" =>  [
            { "archived" => 0 },
            { "status_invoice" => 3 },      # Bill - Import from Shopify
            { "status_payment" => 3 },      # Pay - Sale Order is marked as paid
            #{ "status_packing_slip"=> 1 },
            { "status_package"=> 0 },
            { "status_deliver"=> 0 },
          ]
        },
        "sort" => [
          {
            "order_date" => "desc"
          }
        ]
      }

      @response = Base::stitch_request('api2/v2/SalesOrders', body)

      data = JSON.parse(@response)
      exist_data = data['SalesOrders'].count

      return nil if exist_data == 0

      sales_orders = data['SalesOrders']
      sales_orders_ids = sales_orders.map { |order| order['id'] }
      return sales_orders_ids
    end # get_open_sales_orders_ids

    def self.find_by_id(sales_order_id)
      body = {
        "action" => "read",
        "SalesOrders" => [
          {
            "id" =>  sales_order_id
          }
        ]
      }

      @response = Base::stitch_request('api2/v2/SalesOrders/detail', body)

      data = JSON.parse(@response)
      exist_data = data['SalesOrders'].count

      return nil if exist_data == 0
      return data

    end # find_by

  end
end
