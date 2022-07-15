class AddTrigramIndexToProducts < ActiveRecord::Migration[5.2]
  def up
    enable_extension 'pg_trgm'
    add_index(:products, :name, using: 'gin', opclass: :gin_trgm_ops)
  end

  def down
    disable_extension 'pg_trgm'
    remove_index(:products, :name)
  end
end
