# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SunnyEpisode do
  let!(:excellent_episode) { create(:sunny_episode, title: 'The Gang Runs for Office') }
  let!(:ok_episode)        { create(:sunny_episode, title: 'Mac and Dennis: Manhunters') }
  let!(:bad_episode)       { create(:sunny_episode, title: 'The Gang Goes on Family Fight') }
  let!(:terrible_epsiode)  { create(:sunny_episode, title: 'The Gang Goes to Ireland') }

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
    it 'returns two randomly selected sunny episodes' do
      expect(described_class.random_two).to match_array(
        [a_kind_of(described_class), a_kind_of(described_class)]
      )
    end
  end

  describe '.top_hundred' do
    let!(:user1) { create(:user) }
    let!(:user2) { create(:user) }
    let!(:user3) { create(:user) }

    before do
      create(:sunny_episode_user_ranking, user: user1, better_episode: excellent_episode, worse_episode: ok_episode)
      create(:sunny_episode_user_ranking, user: user1, better_episode: excellent_episode, worse_episode: bad_episode)
      create(:sunny_episode_user_ranking, user: user1, better_episode: ok_episode,        worse_episode: bad_episode)
      create(:sunny_episode_user_ranking, user: user2, better_episode: excellent_episode, worse_episode: ok_episode)
      create(:sunny_episode_user_ranking, user: user2, better_episode: excellent_episode, worse_episode: bad_episode)
      create(:sunny_episode_user_ranking, user: user2, better_episode: ok_episode,        worse_episode: bad_episode)
      create(:sunny_episode_user_ranking, user: user3, better_episode: excellent_episode, worse_episode: ok_episode)
      create(:sunny_episode_user_ranking, user: user3, better_episode: bad_episode,
                                          worse_episode: terrible_epsiode)
      create(:sunny_episode_user_ranking, user: user3, better_episode: ok_episode, worse_episode: bad_episode)
    end

    it 'returns the best 10 (episodes with wins) episodes in order' do
      expect(described_class.top_hundred).to eq([
                                                  excellent_episode,
                                                  ok_episode,
                                                  bad_episode
                                                ])
    end
  end
end
