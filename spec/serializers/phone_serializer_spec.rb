# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PhoneSerializer, type: :serializer do
  let!(:phone) { build(:phone) }
  let!(:serializer) { described_class.new(phone) }
  let!(:serialization) { ActiveModelSerializers::Adapter.create(serializer) }
  let!(:serialized) { JSON.parse(serialization.to_json) }

  it 'serializes the model' do
    expect(serialized).to eq('number' => phone.number)
  end
end
