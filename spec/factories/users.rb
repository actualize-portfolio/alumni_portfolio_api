# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:username) { |n| "test_user_#{n}" }
    password { 'p@ssw@rd' }

    trait :with_avatar do
      avatar { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/images/user_avatar.png'), 'image/png') }
    end
  end
end
