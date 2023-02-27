# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::SunnyEpisodeUserRankings' do
  include RequestSpecHelper

  let(:user) { create(:user, password:) }
  let!(:bad_episode) { create(:sunny_episode, title: "Paddy's Has a Jumper") }
  let!(:good_episode) { create(:sunny_episode, title: 'The Gang Beats Boggs') }

  let(:password) { 'p@ssw@rd' }
  let(:headers) { { 'Authorization' => "Bearer #{token}", 'Content-Type' => 'application/json' } }
  let(:token) { login_user_for_token(user.username, password) }

  describe 'GET /index' do
    before { get(api_v1_sunny_episode_user_rankings_path, headers:) }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'returns a collection of data' do
      expect(data).to match([a_kind_of(Hash), a_kind_of(Hash)])
    end
  end

  describe 'GET /create' do
    let(:params) do
      { worse_id: bad_episode.id, better_id: good_episode.id }.to_json
    end
    let(:create_ranking) { post(api_v1_sunny_episode_user_rankings_path, params:, headers:) }

    it 'returns http success' do
      create_ranking
      expect(response).to have_http_status(:success)
    end

    context 'when user has previously ranked the two episodes' do
      before do
        create(:sunny_episode_user_ranking, user:, better_episode: good_episode, worse_episode: bad_episode)
      end

      it 'removes the old ranking and creates a new ranking' do
        expect { create_ranking }.not_to change(SunnyEpisodeUserRanking, :count)
      end
    end

    context 'when user has previously ranked the two episodes but has changed their mind' do
      before do
        create(:sunny_episode_user_ranking, user:, better_episode: bad_episode, worse_episode: good_episode)
      end

      it 'removes the old ranking and creates a new ranking' do
        expect { create_ranking }.not_to change(SunnyEpisodeUserRanking, :count)
      end
    end
  end
end
