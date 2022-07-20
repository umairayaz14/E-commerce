# frozen_string_literal: true

class AddIndexToCoupon < ActiveRecord::Migration[5.2]
  def change
    add_index :coupons, :name, unique: true
  end
end
