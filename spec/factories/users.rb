# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:username) { |n| "test#{n}" }
    sequence(:email) { |n| "#{username}#{n}@example.com" }
    password { '123456' }
  end
end
