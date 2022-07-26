# frozen_string_literal: true

FactoryBot.define do
  factory :coupon do
    sequence(:name) { |n| "coupon#{n}" }
    value { 0.5 }
    valid_til { '2022-07-22 ' }
  end
end
