FactoryBot.define do
  factory :question do
    inquiry { 'Factory Question?' }
    sequence(:exercise_id)
  end
end
