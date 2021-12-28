# frozen_string_literal: true

class CreateLocations < ActiveRecord::Migration[6.1]
  def change
    create_table :locations do |t|
      t.integer :resource_id, null: false
      t.integer :address_id, null: false

      t.timestamps
    end

    add_index :locations, %i[resource_id address_id], unique: true
  end
end
