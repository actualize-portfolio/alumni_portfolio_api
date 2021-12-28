# frozen_string_literal: true

class CreateResources < ActiveRecord::Migration[6.1]
  def change
    create_table :resources do |t|
      t.string :name, null: false
      t.string :desc, null: false

      t.timestamps
    end

    add_index :resources, :name
  end
end
