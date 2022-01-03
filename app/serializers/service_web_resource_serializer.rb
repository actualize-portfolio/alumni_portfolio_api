# frozen_string_literal: true

# ServiceWebResource Serializer
class ServiceWebResourceSerializer < ActiveModel::Serializer
  attributes :name, :desc

  has_many :addresses
  has_many :phones
end
