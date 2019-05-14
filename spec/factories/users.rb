FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "person#{n}@example.com" }
    sequence(:password) { |n| "amazing_secure_password#{n}" }
  end
end