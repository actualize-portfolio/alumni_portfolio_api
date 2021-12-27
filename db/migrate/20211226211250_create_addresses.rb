# frozen_string_literal: true

class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.string :street1, null: false
      t.string :street2
      t.string :city, null: false
      t.string :state, null: false, limit: 2
      t.string :zip, null: false
      t.float :latitude
      t.float :longitude

      t.timestamps
    end

    add_index :addresses, %i[latitude longitude]
  end
end
