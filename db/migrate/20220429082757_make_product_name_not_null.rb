class MakeProductNameNotNull < ActiveRecord::Migration[5.2]
  def change
    change_column :products, :name, :string, null: false
  end
end
