FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "email_#{n}_@example.com" }
    sequence(:password) { |n| "password_#{n}" }
  end
end
