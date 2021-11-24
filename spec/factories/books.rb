# frozen_string_literal: true

FactoryBot.define do
  factory :book do
    title { 'MyString' }
    author { 'MyString' }
    img_url { 'MyString' }
    page_count { 1 }
  end
end
