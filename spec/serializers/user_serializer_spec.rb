# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserSerializer, type: :serializer do
  let!(:user) { create(:user) }
  let!(:serializer) { described_class.new(user, favorites: []) }
  let!(:serialization) { ActiveModelSerializers::Adapter.create(serializer) }
  let!(:serialized) { JSON.parse(serialization.to_json) }

  let(:expected) do
    {
      "avatar_url" => user.avatar.url,
      "username" => user.username
    }
  end

  it 'serializes the model' do
    expect(serialized).to eq(expected)
  end
end
