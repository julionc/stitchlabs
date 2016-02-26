require 'test_helper'
require 'minitest/mock'
require 'webmock/minitest'

class PackageCarrierTypeTest < ActiveSupport::TestCase
  setup do
    Stitchlabs.configure do |config|
      config.client_id = 'client_id'
      config.client_secret = 'client_secret'
      config.token = 'token'
      config.site = 'http://dummy.stitchlabs.com'
      config.api_url = 'https://api-pub.stitchlabs.com'
    end
    @raw_data = File.open(__dir__ + '/../fixtures/package_carrier_types/all.json')
    @url = 'https://api-pub.stitchlabs.com/api2/v2/2/PackageCarrierTypes'
  end

  test 'all' do
    stub_post(@url, { action: 'read' }, @raw_data)
    carrier_types = Stitchlabs::PackageCarrierType.all
    assert_equal 6, carrier_types.count
    assert 'USPS', carrier_types.first['name']
  end

  test 'find' do
    stub_post(@url, { action: 'read' }, @raw_data)
    carrier_type = Stitchlabs::PackageCarrierType.find('DHL')
    assert_kind_of Hash, carrier_type
    assert_equal 'DHL', carrier_type['name']
    assert_equal '1946418', carrier_type['id']
  end
end
