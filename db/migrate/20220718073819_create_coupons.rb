# frozen_string_literal: true

class CreateCoupons < ActiveRecord::Migration[5.2]
  def change
    create_table :coupons do |t|
      t.string :name
      t.decimal :value
      t.date :valid_til

      t.timestamps
    end
  end
end
