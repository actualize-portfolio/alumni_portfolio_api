# frozen_string_literal: true

FactoryBot.define do
  factory :sunny_episode do
    title { 'The Gang Creates an Episode Ranker' }
    description { '' }
    sequence(:number)
    sequence(:season)
    sequence(:episode)
    airdate { '2022-03-17' }
    tvmaze_link { 'https://www.tvmaze.com/episodes/32542/its-always-sunny-in-philadelphia-2x05-hundred-dollar-baby' }
  end
end
