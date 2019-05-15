require 'rails_helper'

describe EAnswer do
  let(:exercise) { FactoryBot.create(:exercise) }
  let(:rehearsal) { FactoryBot.create(:rehearsal) }
  let(:e_question) { FactoryBot.create(:e_question) }
  let(:e_answer) { FactoryBot.create(:e_answer) }

  it 'returns an exercise answer as a string' do
    e_answer = FactoryBot.create(:e_answer, answer: 'Yes, I practice it every day.')
    expect(e_answer.answer). to eq 'Yes, I practice it every day.'
  end

  it 'can be accessed via an e_question' do
    e_answer = FactoryBot.create(:e_answer, e_question_id: e_question.id)
    expect(e_question.e_answers).to include(e_answer)
  end

  it 'can be accessed via a rehearsal, since it is a nested attribute of rehearsal via e_question' do
    e_answer = FactoryBot.create(:e_answer, rehearsal_id: rehearsal.id)
    expect(rehearsal.e_answers).to include(e_answer)
  end
end
