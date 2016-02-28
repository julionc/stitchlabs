# Stitchlabs

Ruby wrapper for the Stitch Labs API.

## Requirements

You have to generate the Stitch Labs Token.
You have an option to generate using the Postman method describing in the document.
See `Stitch Labs Public API Overview - Authentication.pdf` for detail.

## Usage

Setup the Stitch Labs client:

```ruby
require 'stitchlabs'

Stitchlabs.configure do |config|
  config.client_id 	= YOUR_CLIENT_ID
  config.client_secret 	= YOUR_CLIENT_SECRECT
  config.token 	= YOUR_TOKEN
  config.client_id 	= YOUR_CLIENT_ID
  config.api_url = YOUR_API_URL
end
```

### Sales Orders

Get all Open Sales Order Ids.
```ruby
sales_orders_ids = Stitchlabs::SalesOrder.open_sales_orders_ids
```

Get a Sales Order by Id.
```ruby
sale_order = Stitchlabs::SalesOrder.find_by_id(533943058)
```

### Variants

Get a variant by SKU.
```ruby
@sku = 'MKUM1-KT' # Ultimaker 3D Printer
variant = Stitchlabs::Variant.find_by_sku(@sku)
```

Set the variant amount.
```ruby
@sku = 'MSRPIK2' # Make: Raspberry Pi B Starter Kit
@variant = Stitchlabs::Variant.find_by_sku(@sku)
@variant.update_amount(100) # units
# return true - if everything is OK
```

### Packing Slips

Create  a Packing Slip.

```ruby
@sale_order = Stitchlabs::SalesOrder.find_by_id(533943058)
@addresses = Stitchlabs::SalesOrder.addresses # You can get the ID here.

params = {
	my_date: '2015-03-26T08:00:00+0000',
	address_id: '262724054',
	contact_id: '245676758',
	line_item_id: '1205627736',
	line_item_quantity: '1',
	line_item_order_sku_id: 'MKPX10', # 2-Axis Joystick
	sales_order_id: '531936984'
}

packing_slip = Stitchlabs::PackingSlip.new(params)
# Return > 298493340
```

## Package Carrier Type

Get all Package Carrier Types list

```ruby
package_carries = Stitchlabs::PackageCarrierType.all
```

Find a Specific Carrier Types by name

```ruby
carrier = Stitchlabs::PackageCarrierType.find('USPS')
#    {
#      "created_at": "2016-02-08T22:57:11+00:00",
#      "deleted": "0",
#      "id": "1946376",
#      "links": [],
#      "name": "USPS",
#      "updated_at": "2016-02-08T22:57:11+00:00"
#    }
```

### Package

First, you need to create a package slip if you want to create a 
new package with her tracking number correspondingly.

```ruby
package = Stitchlabs::Package.new
package.ship_date = "2015-03-22T08:00:00+0000"
package.packing_slips = 298493340
package.package_carrier_type = 1946376
package.sales_order = 533943058
package.tracking_number = 123123123
package.tracking_link = 'http://google.com'
package.cost = 0
package.delivered = 0
package.save

package_id = package.id
```