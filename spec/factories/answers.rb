FactoryBot.define do
  factory :answer do
    reply { 'reply' }
    sequence(:rehearsal_id)
    sequence(:question_id)
  end
end
