json.extract! comment, :id, :name, :description, :user_id, :product_id, :created_at, :updated_at
json.url comment_url(comment, format: :json)
