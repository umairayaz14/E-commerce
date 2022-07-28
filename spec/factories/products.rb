# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    name { 'test' }
    description { 'testdescription' }
    quantity { 5 }
    price { 200 }
    user
  end
end
