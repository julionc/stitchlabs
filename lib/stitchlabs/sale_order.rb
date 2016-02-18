require 'json'

module Stitchlabs

  class SaleOrder < Stitchlabs::Base

    def self.get_open_orders(page_num=1)
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

      data =JSON.parse(@response)
      exist_data = data['SalesOrders'].count

      return nil if exist_data == 0

      @sale_orders = data['SalesOrders'] 

    end # get_open_orders

  end
end
