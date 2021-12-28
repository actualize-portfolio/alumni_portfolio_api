# frozen_string_literal: true

FactoryBot.define do
  factory :phone do
    location
    sequence(:number) { |n| "3124555#{1000 + n}" }
  end
end
