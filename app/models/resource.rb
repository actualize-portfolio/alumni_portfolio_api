# frozen_string_literal: true

# A resource parent class.
class Resource < ApplicationRecord
  has_many :locations, dependent: :destroy
  has_many :addresses, through: :locations
  has_many :phones, through: :locations

  validates :name, :desc, presence: true

  def add_location(address)
    addresses << address
  end
end
