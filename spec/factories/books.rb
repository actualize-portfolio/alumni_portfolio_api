# frozen_string_literal: true

FactoryBot.define do
  factory :book do
    title { Faker::Book.title }
    author { Faker::Book.author }
    img_url { Faker::LoremFlickr.image }
    page_count { rand(200..500) }
  end
end
