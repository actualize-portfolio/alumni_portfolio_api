# frozen_string_literal: true

Address.destroy_all
ServiceWebResource.destroy_all

address = Address.new(
  street1: '4000 N Western Ave',
  street2: 'Suite 2',
  city: 'Chicago',
  state: 'IL',
  zip: '60618'
)

address.geocode_and_save!

resource = ServiceWebResource.create!(name: 'Kitchen', desc: 'Free meals')
location = resource.locations.create!(address: address)
location.phones.create!(number: '3125551212')
