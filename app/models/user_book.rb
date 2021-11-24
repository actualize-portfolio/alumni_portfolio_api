# frozen_string_literal: true

# Join table representing favorite books
class UserBook < ApplicationRecord
  belongs_to :user
  belongs_to :book
end
