# frozen_string_literal: true

class Location < ApplicationRecord
  belongs_to :resource
  belongs_to :address

  has_many :phones, dependent: :destroy
end
