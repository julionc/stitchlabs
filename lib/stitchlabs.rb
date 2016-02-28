require 'stitchlabs/configuration'
require 'stitchlabs/error'

require 'stitchlabs/base'
require 'stitchlabs/package'
require 'stitchlabs/package_carrier_type'
require 'stitchlabs/packing_slip'
require 'stitchlabs/sales_order'
require 'stitchlabs/variant'

# StitchLabs
module Stitchlabs
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configuration=(config)
    @configuration = config
  end

  def self.configure
    yield configuration if block_given?
  end
end
