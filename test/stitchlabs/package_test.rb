require 'test_helper'
require 'minitest/mock'
require 'webmock/minitest'

class PackageTest < ActiveSupport::TestCase
  setup do
    Stitchlabs.configure do |config|
      config.client_id = 'client_id'
      config.client_secret = 'client_secret'
      config.token = 'token'
      config.site = 'http://dummy.stitchlabs.com'
      config.api_url = 'https://api-pub.stitchlabs.com'
    end
  end

  test 'new' do
    raw_data = File.open(__dir__ + '/../fixtures/package/new_package.json')
    url = 'https://api-pub.stitchlabs.com/api2/v1/Packages'

=begin    
    ship_date = "2015-03-22T08:00:00+0000"
    packing_slips_id = '298493340'
    package_carrier_type_id = '1946376'
    sales_order_id = '533943058'
    tracking_number = '123123123'

    body = {
      action: 'write',
      'Packages' => {
        'ship_date': ship_date,
        'notes': 'notes go here',
        'tracking_link': 'http://google.com',
        'tracking_number': tracking_number,
        #'cost': 0,
        #'delivered': 0,
        'links' => {
          'PackingSlips' => [{ id: packing_slips_id }],
          'PackageCarrierTypes' => [{ id: package_carrier_type_id }],
          'SalesOrders' => [{ id: sales_order_id }]
        }
      }
    }

    stub_post(url, body, raw_data)
=end

    stub_request(:post, url).
      with(:body => "{\"action\":\"write\",\"Packages\":[{\"ship_date\":\"2015-03-22T08:00:00+0000\",\"notes\":null,\"tracking_link\":\"http://google.com\",\"tracking_number\":\"123123123\",\"cost\":0,\"delivered\":0,\"links\":{\"PackingSlips\":[{\"id\":\"298493340\"}],\"PackageCarrierTypes\":[{\"id\":\"1946376\"}],\"SalesOrders\":[{\"id\":\"533943058\"}]}}]}",
           :headers => {'Access-Token'=>'token', 'Content-Type'=>'application/json;charset=UTF-8', 'User-Agent'=>'Typhoeus - https://github.com/typhoeus/typhoeus'}).
      to_return(:status => 200, :body => raw_data, :headers => {})

    package = Stitchlabs::Package.new
    package.ship_date = "2015-03-22T08:00:00+0000"
    package.packing_slips = 298493340
    package.package_carrier_type = 1946376
    package.sales_order = 533943058
    package.tracking_number = 123123123
    package.tracking_link = 'http://google.com'
    package.cost = 0
    package.delivered = 0

    package.save
    assert_equal 263840722, package.id
  end
end
