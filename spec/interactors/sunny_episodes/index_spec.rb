# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SunnyEpisodes::Index, type: :interactor do
  subject(:context) { described_class.call(params) }

  let(:user) { create(:user) }
  let(:params) { { user: user } }

  before do
    create_list(:sunny_episode_user_ranking, 100, user: user)
  end

  describe '.call' do
    it 'succeeds' do
      expect(context).to be_a_success
    end

    it 'returns top ten episodes', :aggregate_failures do
      expect(context.top_ten).to all(be_a_kind_of(SunnyEpisode))
      expect(context.top_ten.size).to be(10)
      expect(context.top_ten_by_user).to all(be_a_kind_of(SunnyEpisode))
      expect(context.top_ten_by_user.size).to be(10)
    end
  end
end
