# frozen_string_literal: true

FactoryBot.define do
  factory :address do
    street1 { '121 N Lasalle' }
    street2 { 'Suite 2' }
    city { 'Chicago' }
    state { 'IL' }
    zip { '60602' }
    latitude { 41.956837 }
    longitude { -87.688713 }

    trait :without_coordinates do
      latitude { nil }
      longitude { nil }
    end
  end
end
