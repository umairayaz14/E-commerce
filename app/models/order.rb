# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :user, optional: true

  has_many :line_items, dependent: :destroy
end
