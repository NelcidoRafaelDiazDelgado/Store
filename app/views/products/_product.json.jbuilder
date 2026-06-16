json.extract! product, :id, :name, :description, :price, :sku, :minimum, :amount, :status, :created_at, :updated_at
json.url product_url(product, format: :json)
