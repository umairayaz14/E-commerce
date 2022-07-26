# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    name { 'testcomment' }
    description { 'testcommentdescription' }
    user
    product
  end
end
