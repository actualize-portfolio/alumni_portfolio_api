# frozen_string_literal: true

class RemoveAgeFromUser < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :age, :integer
  end
end
