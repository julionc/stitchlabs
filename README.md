# Stitchlabs

Ruby wrapper for the Stitch Labs API.

## Requirements

You have to generate the Stitch Labs Token.
You have an option to generate using the Postman method describing in the document.
See `Stitch Labs Public API Overview - Authentication.pdf`

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
sale_order = Stitchlabs::SalesOrder.find_by_id(123456)
```

### Variants

Get a variant by SKU given.
```ruby
@sku = MKUM1-KT # Ultimaker 3D Printer
variant = Stitchlabs::Variant.find_by_sku(@sku)
```

Set the variant amount.
```ruby
@sku = MSRPIK2 # Make: Raspberry Pi B Starter Kit
@variant = Stitchlabs::Variant.find_by_sku(@sku)
@variant.update_amount(100) # units
```

### Packing Slips

Create  a Packing Slip

```ruby
@sale_order = Stitchlabs::SalesOrder.find_by_id(123456)
@address_id = @sale_order.addresses.


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
# return > 298399708
```

## Package Carrier Type

```ruby
package_carries = Stitchlabs::PackageCarrierType.all
```

### Package

First, you need to create a package slip if you want to create a 
new package with her tracking number correspondingly.