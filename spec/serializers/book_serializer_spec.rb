# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BookSerializer, type: :serializer do
  let!(:book) { create(:book) }
  let!(:serializer) { described_class.new(book, favorites: []) }
  let!(:serialization) { ActiveModelSerializers::Adapter.create(serializer) }
  let!(:serialized) { JSON.parse(serialization.to_json) }

  let(:expected) do
    {
      'id' => book.id,
      'title' => book.title,
      'author' => book.author,
      'img_url' => book.img_url,
      'page_count' => book.page_count,
      'is_favorite' => false
    }
  end

  it 'serializes the model' do
    expect(serialized).to eq(expected)
  end
end
