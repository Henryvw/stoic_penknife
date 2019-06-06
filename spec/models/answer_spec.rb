require 'rails_helper'

describe Answer do
  let(:exercise) { FactoryBot.create(:exercise) }
  let(:rehearsal) { FactoryBot.create(:rehearsal) }
  let(:question) { FactoryBot.create(:question) }
  let(:answer) { FactoryBot.create(:answer) }

  it 'returns an exercise answer as a string' do
    answer = FactoryBot.create(:answer, reply: 'Yes, I practice it every day.')
    expect(answer.reply). to eq 'Yes, I practice it every day.'
  end

  it 'can be accessed via an question' do
    answer = FactoryBot.create(:answer, question: question)
    expect(question.answers).to include(answer)
  end

  it 'can be accessed via a rehearsal, since it is a nested attribute of rehearsal via question' do
    answer = FactoryBot.create(:answer, rehearsal_id: rehearsal.id)
    expect(rehearsal.answers).to include(answer)
  end
end
