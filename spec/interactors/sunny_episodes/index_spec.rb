# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SunnyEpisodes::Index, type: :interactor do
  subject(:context) { described_class.call(params) }

  let(:user) { create(:user) }
  let(:user_without_rankings) { create(:user) }
  let(:params) { { user: } }

  let!(:excellent_episode) { create(:sunny_episode, title: 'The Gang Runs for Office') }
  let!(:ok_episode)        { create(:sunny_episode, title: 'Mac and Dennis: Manhunters') }
  let!(:bad_episode)       { create(:sunny_episode, title: 'The Gang Goes on Family Fight') }
  let!(:terrible_epsiode)  { create(:sunny_episode, title: 'The Gang Goes to Ireland') }

  describe '.call' do
    before do
      create_list(:sunny_episode_user_ranking, 50, user:, better_episode: excellent_episode, worse_episode: bad_episode)
      create_list(:sunny_episode_user_ranking, 50, user:, better_episode: ok_episode, worse_episode: bad_episode)
      create_list(:sunny_episode_user_ranking, 50, user:, better_episode: bad_episode, worse_episode: terrible_epsiode)
    end

    context 'when user has rankings' do
      it 'succeeds' do
        expect(context).to be_a_success
      end

      it 'returns top episodes information for public and user', :aggregate_failures do
        expect(context.top_hundred).to all(be_a(SunnyEpisode))
        expect(context.top_hundred.size).to be(3)
        expect(context.top_hundred_by_user).to all(be_a(SunnyEpisode))
        expect(context.top_hundred_by_user.size).to be(3)
      end
    end

    context 'when user has no rankings' do
      let(:params) { { user: user_without_rankings } }

      it 'succeeds' do
        expect(context).to be_a_success
      end

      it 'returns top episodes information for public and user', :aggregate_failures do
        expect(context.top_hundred).to all(be_a(SunnyEpisode))
        expect(context.top_hundred.size).to be(3)
        expect(context.top_hundred_by_user).to eq([])
      end
    end
  end
end
