json.extract! product, :id, :title, :discription, :image_url, :price, :created_at, :updated_at
json.url product_url(product, format: :json)
