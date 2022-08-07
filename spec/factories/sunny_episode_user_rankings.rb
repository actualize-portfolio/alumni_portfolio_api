# frozen_string_literal: true

FactoryBot.define do
  factory :sunny_episode_user_ranking do
    user
    better_episode { SunnyEpisode.order('RANDOM()').limit(1).first }
    worse_episode { SunnyEpisode.order('RANDOM()').limit(1).first }
  end
end
