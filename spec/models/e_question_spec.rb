require 'rails_helper'

describe EQuestion do
  let(:e_question) { FactoryBot.create(:e_question) }

  it 'returns an exercise question as a string' do
    e_question = FactoryBot.create(:e_question, question: 'Do you practice the Discipline of Assent?')
    expect(e_question.question).to eq 'Do you practice the Discipline of Assent?'
  end

  it 'returns a list of its associated e_answers' do
    e_answer = FactoryBot.create(:e_answer, answer: 'Yes, I love it.')
    e_question = FactoryBot.create(:e_question, e_answers: [e_answer])
    expect(e_question.e_answers).to include(e_answer)
  end

  it 'can be accessed via an exercise' do
    exercise = FactoryBot.create(:exercise, e_questions: [e_question])
    expect(exercise.e_questions).to include(e_question)
  end
end
