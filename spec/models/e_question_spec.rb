require 'rails_helper'

describe Question do
  let(:question) { FactoryBot.create(:question) }

  it 'returns an exercise question as a string' do
    question = FactoryBot.create(:question, question: 'Do you practice the Discipline of Assent?')
    expect(question.question).to eq 'Do you practice the Discipline of Assent?'
  end

  it 'returns a list of its associated e_answers' do
    e_answer = FactoryBot.create(:e_answer, reply: 'Yes, I love it.')
    question = FactoryBot.create(:question, e_answers: [e_answer])
    expect(question.e_answers).to include(e_answer)
  end

  it 'can be accessed via an exercise' do
    exercise = FactoryBot.create(:exercise, questions: [question])
    expect(exercise.questions).to include(question)
  end
end
