# frozen_string_literal: true

FactoryBot.define do
  factory :sunny_episode_user_ranking do
    user_id { 1 }
    better_episode_id { 1 }
    worse_episode_id { 1 }
  end
end
