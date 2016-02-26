require 'test_helper'
require 'minitest/mock'
require 'webmock/minitest'

class SalesOrderTest < ActiveSupport::TestCase
  setup do
    Stitchlabs.configure do |config|
      config.client_id = 'client_id'
      config.client_secret = 'client_secret'
      config.token = 'token'
      config.site = 'http://dummy.stitchlabs.com'
      config.api_url = 'https://api-pub.stitchlabs.com'
    end
  end

  test 'get open sales orders ids' do
    raw_data = File.open(__dir__ + '/../fixtures/sale_orders/find_sale_orders.json')
    url = 'https://api-pub.stitchlabs.com/api2/v2/SalesOrders'
    body = {
      action: 'read',
      page_size: 50,
      page_num: 1,
      filter: {
        'and' => [
          { archived: 0 },
          { status_invoice: 3 },
          { status_payment: 3 },
          { status_package: 0 },
          { status_deliver: 0 }
        ]
      },
      sort: [{
        order_date: 'desc'
      }]
    }
    stub_post(url, body, raw_data)

    sales_orders_ids = Stitchlabs::SalesOrder.open_sales_orders_ids
    assert_equal 7, sales_orders_ids.count
    assert_kind_of Array, sales_orders_ids
  end

  test 'get a sales order by id' do
    raw_data = File.open(__dir__ + '/../fixtures/sale_orders/sale_order_533943058.json')
    url = 'https://api-pub.stitchlabs.com/api2/v2/SalesOrders/detail'
    body = { action: 'read', 'SalesOrders' => [{ id: 533943058 }] }

    sale_order_id = 533943058
    stub_post(url, JSON.dump(body), raw_data)
    @sales_order = Stitchlabs::SalesOrder.find_by_id(sale_order_id)

    first_sales_order = @sales_order['SalesOrders'].first
    assert_equal '533943058', first_sales_order['id']
  end

  test 'get others attributes from a sales order' do
    raw_data = File.open(__dir__ + '/../fixtures/sale_orders/sale_order_533943058.json')
    url = 'https://api-pub.stitchlabs.com/api2/v2/SalesOrders/detail'
    body = { action: 'read', 'SalesOrders' => [{ id: 533943058 }] }

    sale_order_id = 533943058
    stub_post(url, JSON.dump(body), raw_data)
    @sales_order = Stitchlabs::SalesOrder.find_by_id(sale_order_id)

    first_sales_order = @sales_order['SalesOrders'].first
    assert_equal '533943058', first_sales_order['id']
    assert_kind_of Hash, Stitchlabs::SalesOrder.addresses
    assert_kind_of Hash, Stitchlabs::SalesOrder.contacts
    assert_kind_of Hash, Stitchlabs::SalesOrder.line_items
  end

end
