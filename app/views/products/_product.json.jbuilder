json.extract! product, :id, :name, :description, :amount, :min, :price, :status, :sku, :created_at, :updated_at
json.url product_url(product, format: :json)
