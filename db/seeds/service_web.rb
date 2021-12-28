# frozen_string_literal: true

Address.delete_all
Resource.delete_all
Location.delete_all
Phone.delete_all

address = Address.create!(
  street1: '4000 N Western Ave',
  city: 'Chicago',
  state: 'IL',
  zip: '60618'
)

resource = Resource.create!(name: 'Kitchen', desc: 'Free meals')
location = Location.create!(address: address, resource: resource)
Phone.create!(location: location, number: '3125551212')
