# frozen_string_literal: true

FactoryBot.define do
  factory :location do
    service_web_resource
    address
  end
end
