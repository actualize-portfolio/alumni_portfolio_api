# frozen_string_literal: true

# A US address class.
class Address < ApplicationRecord
  geocoded_by :full_address

  has_many :locations, dependent: :destroy
  has_many :resources, through: :locations
  has_many :phones, through: :locations

  validates :street1, :city, :state, :zip, presence: true
  validates :zip, numericality: true
  validates :latitude, :longitude, numericality: true, allow_nil: true
  validate :valid_state_code

  STATES = %w[AK AL AR AZ CA CO CT DC DE FL GA HI IA ID IL IN KS
              KY LA MA MD ME MI MN MO MS MT NC ND NE NH NJ NM NV
              NY OH OK OR PA RI SC SD TN TX UT VA VT WA WI WV WY].freeze

  def full_address
    [street1, city, state, zip].compact.join(', ')
  end

  def coordinates?
    latitude.present? && longitude.present?
  end

  private

  def valid_state_code
    errors.add :state, 'invalid state code' unless state.in?(STATES)
  end
end
