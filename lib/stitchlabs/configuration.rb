module Stitchlabs
  class Configuration

    # Settings.
    # `config/initializers/stitchlabs.rb`
    attr_accessor :client_id
    attr_accessor :client_secret
    attr_accessor :token
    attr_accessor :site
    attr_accessor :api_url
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configuration=(config)
    @configuration = config
  end

  def self.configure
    yield configuration
  end

end
