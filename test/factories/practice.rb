# frozen_string_literal: true

FactoryBot.define do
  factory :practice do
    practice_date { Time.zone.now }
    minutes { 30 }
    notes { 'This is a note' }
    user
  end
end
