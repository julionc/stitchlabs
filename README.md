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
Stitchlabs::SalesOrder.find_by_id(123456)
```

### Variants

Get a variant by SKU given.
```ruby
@sku = MKUM1-KT # Ultimaker 3D Printer
Stitchlabs::Variant.find_by_sku(@sku)
```

Set the variant amount.
```ruby
@sku = MSRPIK2 # Make: Raspberry Pi B Starter Kit
@variant = Stitchlabs::Variant.find_by_sku(@sku)
update = @variant.update_amount(100) # units
```