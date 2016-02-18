require 'test_helper'
require 'minitest/mock'
require 'webmock/minitest'

class SaleOrderTest < ActiveSupport::TestCase

	setup do
		Stitchlabs.configure do |config|
			config.client_id = 'client_id'
			config.client_secret = 'client_secret'
			config.token = 'token'
			config.site = 'http://dummy.stitchlabs.com'
			config.api_url = 'https://api-pub.stitchlabs.com'
		end
	end

	test 'get open orders' do
		raw_data = File.open(__dir__ + "/../fixtures/sale_orders/find_sale_orders.json")

    stub_request(:post, "https://api-pub.stitchlabs.com/api2/v2/SalesOrders").
        with(:body => "{\"action\":\"read\",\"page_size\":50,\"page_num\":1,\"filter\":{\"and\":[{\"archived\":0},{\"status_invoice\":3},{\"status_payment\":3},{\"status_package\":0},{\"status_deliver\":0}]},\"sort\":[{\"order_date\":\"desc\"}]}",
                   :headers => {'Access-Token'=>'token', 'Content-Type'=>'application/json;charset=UTF-8', 'User-Agent'=>'Typhoeus - https://github.com/typhoeus/typhoeus'}).
          to_return(:status => 200, :body => raw_data, :headers => {})

		@sale_orders = Stitchlabs::SaleOrder.get_open_orders
		assert_equal 7, @sale_orders.count

	end
end
