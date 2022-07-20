# frozen_string_literal: true

class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy
  has_many :products, through: :line_items

  def sub_total
    line_items.inject(0) { |total, line_item| total + line_item.total_price }
  end

  def total_quantity
    # line_item.pluck(:quantity).sum
    line_items.inject(0) { |total, line_item| total + line_item.quantity }
  end
end
