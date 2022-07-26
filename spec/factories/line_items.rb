# frozen_string_literal: true

FactoryBot.define do
  factory :line_item do
    quantity { 2 }
    product
    cart
  end
end
