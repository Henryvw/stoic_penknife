FactoryBot.define do
  factory :e_answer do
    answer { 'answer' }
    sequence(:rehearsal_id)
    sequence(:e_question_id)
  end
end
