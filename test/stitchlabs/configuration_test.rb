require 'test_helper'

class ConfigurationTest < ActiveSupport::TestCase
  setup do
    Stitchlabs.configuration = nil
  end

  test '#configure' do
    Stitchlabs.configure do |config|
      config.client_id = 'client_id'
      config.client_secret = 'client_secret'
      config.token = 'token'
      config.site = 'http://dummy.stitchlabs.com'
      config.api_url = 'https://api-pub.stitchlabs.com/'
    end
    assert_equal 'client_id', Stitchlabs.configuration.client_id
    assert_equal 'client_secret', Stitchlabs.configuration.client_secret
    assert_equal 'token', Stitchlabs.configuration.token
    assert_equal 'http://dummy.stitchlabs.com', Stitchlabs.configuration.site
    assert_equal 'https://api-pub.stitchlabs.com/', Stitchlabs.configuration.api_url
  end
end
