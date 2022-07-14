# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GithubRepoSerializer, type: :serializer do
  let!(:github_repo) { create(:github_repo) }
  let!(:serializer) { described_class.new(github_repo) }
  let!(:serialization) { ActiveModelSerializers::Adapter.create(serializer) }
  let!(:serialized) { JSON.parse(serialization.to_json) }

  let(:expected) do
    {
      'id' => github_repo.id,
      'name' => 'vue',
      'full_name' => 'vuejs/vue',
      'category' => 'javascript_framework',
      'forks_count' => 32_471,
      'watchers_count' => 197_695,
      'popularity_rating' => 128_215
    }
  end

  it 'serializes the model', vcr: true do
    expect(serialized).to eq(expected)
  end
end
