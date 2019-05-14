FactoryBot.define do
  factory :rehearsal do
    sequence(:exercise_id)
    sequence(:user_id)
    sequence(:city) {|n| "city_#{n}" }
  end
end
