module Stitchlabs

  class Variant < Stitchlabs::Base

    attr_accessor :variant_id
    attr_accessor :sku
    attr_accessor :account_address_id

    def self.find_by_sku(sku)
      body = {
        "action" => "read",
        "filter" => {
          "and" =>  [{
            "sku" => sku.to_s
          }]
        }
      }

      @response = Base::stitch_request('api2/v2/Variants', body)

      data = JSON.parse(@response)

      exist_data = data['Variants'].count

      return nil if exist_data == 0

      variant = data['Variants'].first
      account_address_id = data['AccountAddresses'].first[0]

      @variant = Variant.new
      @variant.variant_id = variant['id']
      @variant.sku = variant['sku']
      @variant.account_address_id = account_address_id

      return @variant

    end # exist_data

    def update_amount(amount)
      body = {
        'action' => 'write',
        'Variants' => [{
          'id' => @variant_id,
          'links' => {
            'ReconcileInventory' => [{
              'change' => 'set_available',
              'units' => amount,
              'links' => {
                'AccountAddresses' => [{
                  'id' => @account_address_id # "My Default Warehouse"
                }]
              }
            }] # ReconcileInventory
          }
        }]
      }
      @response = Base::stitch_request('api2/v1/Variants/detail', body)
    end

  end
end
