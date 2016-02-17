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
      config.api_url = 'https://api-pub.stitchlabs.com/'
    end

    # Product: 1.75mm ABS 1KG Spooled Filament (Black)
    @sku = 'MSF1A-BK'
    @amount = 100
    @account_address_id = 74142
  end

  test 'find a product variant by sku' do
    raw_data = File.open(__dir__ + "/../fixtures/find_variant.json")

    stub_request(:post, "https://api-pub.stitchlabs.com//api2/v1/Variants").
      with(:body => "{\"action\":\"read\",\"filter\":{\"and\":[{\"sku\":\"MSF1A-BK\"}]}}",
           :headers => {'Access-Token'=>'token', 'Content-Type'=>'application/json;charset=UTF-8', 'User-Agent'=>'Typhoeus - https://github.com/typhoeus/typhoeus'}).
      to_return(:status => 200, :body => raw_data, :headers => {})

    @variant = Stitchlabs::Variant.find_by_sku(@sku)

    assert_equal "229617792", @variant.variant_id
    assert_equal "MSF1A-BK", @variant.sku
    assert_equal "74142", @variant.account_address_id

  end

  test 'not found a Product variant using find_by_sku' do

    @sku = '666-666'
    raw_data = File.open(__dir__ + "/../fixtures/not_found_variant.json")

    stub_request(:post, "https://api-pub.stitchlabs.com//api2/v1/Variants").
      with(:body => "{\"action\":\"read\",\"filter\":{\"and\":[{\"sku\":\"666-666\"}]}}",
       :headers => {'Access-Token'=>'token', 'Content-Type'=>'application/json;charset=UTF-8', 'User-Agent'=>'Typhoeus - https://github.com/typhoeus/typhoeus'}).
      to_return(:status => 404, :body => raw_data, :headers => {})

    @variant = Stitchlabs::Variant.find_by_sku(@sku)

    assert_equal nil, @variant
  end

  test 'update the amount of the product variant' do
    raw_data = File.open(__dir__ + "/../fixtures/find_variant.json")

    stub_request(:post, "https://api-pub.stitchlabs.com//api2/v1/Variants").
      with(:body => "{\"action\":\"read\",\"filter\":{\"and\":[{\"sku\":\"MSF1A-BK\"}]}}",
           :headers => {'Access-Token'=>'token', 'Content-Type'=>'application/json;charset=UTF-8', 'User-Agent'=>'Typhoeus - https://github.com/typhoeus/typhoeus'}).
      to_return(:status => 200, :body => raw_data, :headers => {})


    stub_request(:post, "https://api-pub.stitchlabs.com//api2/v1/Variants/detail").
      with(:body => "{\"action\":\"write\",\"Variants\":[{\"id\":\"229617792\",\"links\":{\"ReconcileInventory\":[{\"change\":\"set_available\",\"units\":100,\"links\":{\"AccountAddresses\":[{\"id\":\"74142\"}]}}]}}]}",
           :headers => {'Access-Token'=>'token', 'Content-Type'=>'application/json;charset=UTF-8', 'User-Agent'=>'Typhoeus - https://github.com/typhoeus/typhoeus'}).
      to_return(:status => 200, :body => "", :headers => {})

    @variant = Stitchlabs::Variant.find_by_sku(@sku)
    update = @variant.update_amount(@amount)

    assert_equal '', update # empty: means your response do not have errors
  end

end
