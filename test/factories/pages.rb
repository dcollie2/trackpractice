# frozen_string_literal: true

FactoryBot.define do
  factory :page do
    name { 'This is a name' }
    contents { 'This is contents' }
  end
end
