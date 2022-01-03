# frozen_string_literal: true

# Address Serializer
class AddressSerializer < ActiveModel::Serializer
  attributes :id,
             :street1,
             :street2,
             :city,
             :state,
             :zip,
             :latitude,
             :longitude
end
