# frozen_string_literal: true

# A join table that represents a Resource Location. A single resource
# might look like a company that has several locations, addresses, phones
class Location < ApplicationRecord
  belongs_to :resource
  belongs_to :address

  has_many :phones, dependent: :destroy
end
