FactoryBot.define do
  sequence :email do |n|
    "user#{n}@example.com"
  end

  factory :user do
    email
    # encrypted_password User.new.send(:password_digest, '1234567890') %>
    password { '1234567890' }
    confirmed_at { Time.current - 1.hour }
    confirmation_sent_at { Time.current - 2.hours }
    time_zone { 'UTC' }
    trait :admin do
      admin { true }
    end
    trait :public do
      make_practices_public { true }
    end
  end
end
