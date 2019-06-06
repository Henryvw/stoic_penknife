require 'rails_helper'

describe EAnswer do
  let(:exercise) { FactoryBot.create(:exercise) }
  let(:rehearsal) { FactoryBot.create(:rehearsal) }
  let(:question) { FactoryBot.create(:question) }
  let(:e_answer) { FactoryBot.create(:e_answer) }

  it 'returns an exercise answer as a string' do
    e_answer = FactoryBot.create(:e_answer, answer: 'Yes, I practice it every day.')
    expect(e_answer.answer). to eq 'Yes, I practice it every day.'
  end

  it 'can be accessed via an question' do
    e_answer = FactoryBot.create(:e_answer, question: question)
    expect(question.e_answers).to include(e_answer)
  end

  it 'can be accessed via a rehearsal, since it is a nested attribute of rehearsal via question' do
    e_answer = FactoryBot.create(:e_answer, rehearsal_id: rehearsal.id)
    expect(rehearsal.e_answers).to include(e_answer)
  end
end
