# frozen_string_literal: true

# A book
class Book < ApplicationRecord
  has_many :user_books, dependent: :destroy
  has_many :users, through: :user_books
end
