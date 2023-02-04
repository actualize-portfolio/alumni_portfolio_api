# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SunnyEpisodeUserRanking do
  describe 'relationships' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:better_episode) }
    it { is_expected.to belong_to(:worse_episode) }
  end
end
