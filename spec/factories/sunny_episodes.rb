# frozen_string_literal: true

FactoryBot.define do
  factory :sunny_episode do
    title { 'The Gang Creates an Episode Ranker' }
    description { 'No desc yet' }
    number { 1 }
    season { 1 }
    episode { 1 }
    airdate { '2022-03-17' }
  end
end
