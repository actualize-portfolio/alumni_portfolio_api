# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AddressSerializer, type: :serializer do
  let!(:address) { create(:address) }
  let!(:serializer) { described_class.new(address) }
  let!(:serialization) { ActiveModelSerializers::Adapter.create(serializer) }
  let!(:serialized) { JSON.parse(serialization.to_json) }

  let(:expected) do
    {
      'id' => address.id,
      'city' => address.city,
      'latitude' => address.latitude,
      'longitude' => address.longitude,
      'state' => address.state,
      'street1' => address.street1,
      'street2' => address.street2,
      'zip' => address.zip
    }
  end

  it 'serializes the model' do
    expect(serialized).to eq(expected)
  end
end
