module Stitchlabs
  class Configuration # :nodoc:
    # Settings.
    # `config/initializers/stitchlabs.rb`
    attr_accessor :client_id
    attr_accessor :client_secret
    attr_accessor :token
    attr_accessor :site
    attr_accessor :api_url
  end
end
