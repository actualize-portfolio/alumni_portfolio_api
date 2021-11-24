# frozen_string_literal: true

FactoryBot.define do
  factory :github_repo do
    organization { 'vuejs' }
    project { 'vue' }
    category { :javascript_framework }
  end

  trait :skip_validate do
    organization { 'non-existent-org' }
    to_create { |instance| instance.save(validate: false) }
  end
end
