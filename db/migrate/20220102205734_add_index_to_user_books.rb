# frozen_string_literal: true

class AddIndexToUserBooks < ActiveRecord::Migration[6.1]
  def change
    add_index :user_books, %i[user_id book_id], unique: true
  end
end
