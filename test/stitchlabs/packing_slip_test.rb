require 'test_helper'
require 'minitest/mock'
require 'webmock/minitest'

class PackingSlipTest < ActiveSupport::TestCase
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
    raw_data = File.open(__dir__ + '/../fixtures/packing_slips/new_packing_slips.json')
    url = 'https://api-pub.stitchlabs.com/api2/v1/PackingSlips'

    # NOTE: These parameters must to send as strings
    params = {
      my_date: '2015-03-26T08:00:00+0000',
      address_id: '262724054',
      contact_id: '245676758',
      line_item_id: '1205627736',
      line_item_quantity: '1',
      line_item_order_sku_id: 'MKPX10', # 2-Axis Joystick
      sales_order_id: '531936984'
    }

    body = {
      action: 'write',
      'PackingSlips' => [{
        'packing_slip_date': params[:my_date],
        'notes': 'notes go here',
        'links': {
          'Addresses' => [{ id: params[:address_id] }],
          'Contacts' => [{ id: params[:contact_id] }],
          'LineItems' => [{
            id: params[:line_item_id],
            quantity: params[:line_item_quantity],
            order_sku_id: params[:line_order_sku_id]
          }],
          'SalesOrders' => [{ id: params[:sales_order_id] }]
        }
      }]
    }
    stub_post(url, body, raw_data)
    packing_slip = Stitchlabs::PackingSlip.new(params)
    assert '298399708', packing_slip
  end

end