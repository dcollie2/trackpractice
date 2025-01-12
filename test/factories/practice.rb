FactoryBot.define do
  factory :practice do
    practice_date { Time.zone.now }
    minutes { 30 }
    notes { 'This is a note' }
  end
end
