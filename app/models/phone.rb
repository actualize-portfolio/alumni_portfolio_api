# frozen_string_literal: true

# A phone number
class Phone < ApplicationRecord
  belongs_to :location

  validates :number, presence: true, format: { with: /\d{10}/ }
end
