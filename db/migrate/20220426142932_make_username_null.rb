# frozen_string_literal: true

class MakeUsernameNull < ActiveRecord::Migration[5.2]
  def up
    change_column :users, :username, :string, null: false
  end

  def down
    change_column :users, :username, :string
  end
end
