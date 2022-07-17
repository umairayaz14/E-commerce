# frozen_string_literal: true

class MakeProductNameNotNull < ActiveRecord::Migration[5.2]
  def up
    change_column :products, :name, :string, null: false
  end

  def down
    change_column :products, :name, :string
  end
end
