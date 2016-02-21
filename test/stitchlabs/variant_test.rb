require 'test_helper'
require 'minitest/mock'
require 'webmock/minitest'

class VariantTest < ActiveSupport::TestCase
  setup do
    Stitchlabs.configure do |config|
      config.client_id = 'client_id'
      config.client_secret = 'client_secret'
      config.token = 'token'
      config.site = 'http://dummy.stitchlabs.com'
      config.api_url = 'https://api-pub.stitchlabs.com'
    end
    # Product: 1.75mm ABS 1KG Spooled Filament (Black)
    @sku = 'MSF1A-BK'
    @amount = 100
    @account_address_id = 74142
  end

  test 'find a product variant by sku' do
    raw_data = File.open(__dir__ + '/../fixtures/variant/find_variant.json')
    body = { action: 'read', filter: { 'and' => [{ sku: 'MSF1A-BK' }] } }
    stub_post('https://api-pub.stitchlabs.com/api2/v2/Variants', JSON.dump(body), raw_data)

    @variant = Stitchlabs::Variant.find_by_sku(@sku)

    assert_equal '229617792', @variant.variant_id
    assert_equal 'MSF1A-BK', @variant.sku
    assert_equal '74142', @variant.account_address_id
  end

  test 'not found a Product variant using find_by_sku' do
    raw_data = File.open(__dir__ + '/../fixtures/variant/not_found.json')
    body = { action: 'read', filter: { and: [{ sku: '666-666' }] } }
    @sku = '666-666'

    stub_post(
      'https://api-pub.stitchlabs.com/api2/v2/Variants',
      body,
      raw_data)

    @variant = Stitchlabs::Variant.find_by_sku(@sku)

    assert_equal nil, @variant
  end

  test 'update the amount of the product variant' do
    raw_data = File.open(__dir__ + '/../fixtures/variant/find_variant.json')
    body = { action: 'read', 'filter' => { 'and' => [{ sku: 'MSF1A-BK' }] } }
    stub_post(
      'https://api-pub.stitchlabs.com/api2/v2/Variants',
      JSON.dump(body),
      raw_data)

    # Detail
    body = {
      action: 'write',
      'Variants' => [{
        id: '229617792',
        links: {
          'ReconcileInventory' => [{
            change: 'set_available',
            units: 100,
            links: {
              'AccountAddresses' => [{
                id: '74142'
              }]
            }
          }]
        }
      }]
    }
    stub_post('https://api-pub.stitchlabs.com/api2/v1/Variants/detail', body, '')

    @variant = Stitchlabs::Variant.find_by_sku(@sku)
    update = @variant.update_amount(@amount)
    assert_equal '', update # empty: means your response do not have errors
  end
end
