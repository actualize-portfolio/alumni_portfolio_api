# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:username) { |n| "test_user_#{n}" }
    password { 'p@ssw@rd' }
    age { 25 }
  end
end
