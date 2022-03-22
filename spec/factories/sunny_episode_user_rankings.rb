# frozen_string_literal: true

FactoryBot.define do
  factory :sunny_episode_user_ranking do
    user
    better_episode { create(:sunny_episode) }
    worse_episode { create(:sunny_episode) }
  end
end
