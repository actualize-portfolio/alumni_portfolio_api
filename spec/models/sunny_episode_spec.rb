# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SunnyEpisode, type: :model do
  describe 'relationships' do
    subject { build(:sunny_episode) }

    it { is_expected.to have_many(:wins) }
    it { is_expected.to have_many(:losses) }
  end

  describe 'validations' do
    subject { build(:sunny_episode) }

    it { is_expected.to validate_uniqueness_of(:number) }
    it { is_expected.to validate_uniqueness_of(:episode).scoped_to(:season) }
  end

  describe '.random_two' do
    before { 3.times { create(:sunny_episode) } }

    it 'returns two randomly selected sunny episodes' do
      expect(described_class.random_two).to match_array(
        [a_kind_of(SunnyEpisode), a_kind_of(SunnyEpisode)]
      )
    end
  end

  describe '.top_ten' do
    let!(:user1) { create(:user) }
    let!(:user2) { create(:user) }
    let!(:user3) { create(:user) }

    let!(:excellent_episode) { create(:sunny_episode) }
    let!(:ok_episode)        { create(:sunny_episode) }
    let!(:bad_episode)       { create(:sunny_episode) }
    let!(:terrible_epsiode)  { create(:sunny_episode) }

    before do
      7.times { create(:sunny_episode) }
      create(:sunny_episode_user_ranking, user: user1, better_episode: excellent_episode, worse_episode: ok_episode)
      create(:sunny_episode_user_ranking, user: user1, better_episode: excellent_episode, worse_episode: bad_episode)
      create(:sunny_episode_user_ranking, user: user1, better_episode: ok_episode,        worse_episode: bad_episode)
      create(:sunny_episode_user_ranking, user: user2, better_episode: excellent_episode, worse_episode: ok_episode)
      create(:sunny_episode_user_ranking, user: user2, better_episode: excellent_episode, worse_episode: bad_episode)
      create(:sunny_episode_user_ranking, user: user2, better_episode: ok_episode,        worse_episode: bad_episode)
      create(:sunny_episode_user_ranking, user: user3, better_episode: excellent_episode, worse_episode: ok_episode)
      create(:sunny_episode_user_ranking, user: user3, better_episode: bad_episode,       worse_episode: terrible_epsiode)
      create(:sunny_episode_user_ranking, user: user3, better_episode: ok_episode,        worse_episode: bad_episode)
    end

    it 'returns the best 10 (episodes with wins) episodes in order' do
      expect(described_class.top_ten).to eq([
        excellent_episode,
        ok_episode,
        bad_episode
      ])
    end
  end
end
