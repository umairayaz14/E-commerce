json.array! @products do |product|
  json.id product.id
  json.name product.name
  json.description product.description
  json.price product.price
  json.quantity product.quantity

  # json.product product

  if product.images.attached?
    json.image "http://#{request.host}:#{request.port}#{url_for(product.images.first)}"
  else
    json.image ''
  end
end
