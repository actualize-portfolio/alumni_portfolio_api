# frozen_string_literal: true

class CreatePhones < ActiveRecord::Migration[6.1]
  def change
    create_table :phones do |t|
      t.integer :location_id, null: false
      t.string :number, null: false

      t.timestamps
    end

    add_index :phones, %i[location_id number], unique: true
  end
end
