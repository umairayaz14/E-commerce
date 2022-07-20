# frozen_string_literal: true

class Coupon < ApplicationRecord
  validates :name, :valid_til, :value, presence: true
  validates :name, uniqueness: true
  validates :name, length: { minimum: 4, maximum: 10 }
end
