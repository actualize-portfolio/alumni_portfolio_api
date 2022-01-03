# frozen_string_literal: true

class AddUniqueIndexToBooks < ActiveRecord::Migration[6.1]
  def change
    add_index :books, %i[title author], unique: true
  end
end
