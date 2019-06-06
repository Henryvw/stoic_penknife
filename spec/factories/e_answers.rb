FactoryBot.define do
  factory :e_answer do
    reply { 'reply' }
    sequence(:rehearsal_id)
    sequence(:question_id)
  end
end
