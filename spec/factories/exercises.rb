FactoryBot.define do
  factory :exercise do
    title { 'Senecas Courage Walk' }
    general_description { 'Take a stroll with Seneca and beef up your courage.' }
    global { false }
  end

  trait :socrates_tag do
    after(:build) do |exercise|
      exercise.tags << create(:tag, name: 'Socrates')
    end
  end

  trait :aristotle_tag do
    after(:build) do |exercise|
      exercise.tags << create(:tag, name: 'Aristotle')
    end
  end

  trait :e_question do
    after(:build) do |exercise|
      exercise.e_questions << create(:e_question, question: 'How many Greeks does it take?')
    end
  end
end
