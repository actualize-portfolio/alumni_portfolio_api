# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::SunnyEpisodes', type: :request do
  include RequestSpecHelper

  let!(:user) { create(:user, password: password) }
  let!(:bad_episode) { create(:sunny_episode) }
  let!(:good_episode) { create(:sunny_episode) }

  let(:password) { 'p@ssw@rd' }
  let(:headers) { { 'Authorization' => "Bearer #{token}", 'Content-Type' => 'application/json' } }
  let(:token) { login_user_for_token(user.username, password) }

  describe 'GET /index' do
    before do
      create(:sunny_episode_user_ranking,
             user: user,
             better_episode: good_episode,
             worse_episode: bad_episode)

      get api_v1_sunny_episodes_path, headers: headers
    end

    let(:expected_data) do
      a_hash_including(
        'top_ten' => a_collection_containing_exactly(
          a_hash_including(
            'id' => good_episode.id,
            'title' => good_episode.title,
            'description' => good_episode.description,
            'number' => good_episode.number,
            'season' => good_episode.season,
            'episode' => good_episode.episode,
            'airdate' => good_episode.airdate.to_s,
            'tvmaze_link' => a_string_starting_with('https://www.tvmaze.com')
          )
        ),
        'top_ten_by_user' => a_collection_containing_exactly(
          a_hash_including(
            'id' => good_episode.id,
            'title' => good_episode.title,
            'description' => good_episode.description,
            'number' => good_episode.number,
            'season' => good_episode.season,
            'episode' => good_episode.episode,
            'airdate' => good_episode.airdate.to_s,
            'tvmaze_link' => a_string_starting_with('https://www.tvmaze.com')
          )
        )
      )
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'returns a body' do
      expect(data).to match(expected_data)
    end
  end
end
