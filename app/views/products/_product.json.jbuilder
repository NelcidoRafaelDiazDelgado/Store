json.extract! product, :id, :name, :sku, :description, :price, :category, :amount, :min, :status, :created_at, :updated_at
json.url product_url(product, format: :json)
