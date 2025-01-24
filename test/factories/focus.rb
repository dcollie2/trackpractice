FactoryBot.define do
  factory :focus do
    short_description { 'This is a short description' }
    notes { 'This is a note' }
    user
  end
end
