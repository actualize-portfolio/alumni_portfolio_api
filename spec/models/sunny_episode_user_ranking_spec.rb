# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SunnyEpisodeUserRanking, type: :model do
  describe 'relationships' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:better_episode) }
    it { is_expected.to belong_to(:worse_episode) }
  end
end
