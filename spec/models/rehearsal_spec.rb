require 'rails_helper'

describe Rehearsal, type: :model do
  let(:normal_user) { FactoryBot.create(:user) }
  let(:rehearsal) { FactoryBot.create(:rehearsal) }
  let(:question) { FactoryBot.create(:question) }
  let(:exercise) { FactoryBot.create(:exercise, questions: [question]) }

  it 'has a valid factory-esque (in this case custom) process for faking rehearsal objects' do
    expect(rehearsal).to be_valid
  end

  it 'creates a valid model object when given an exercise_id, a user_id and a city.' do
    rehearsal = Rehearsal.new(
      exercise_id: exercise.id,
      user_id: normal_user.id,
      city: 'Berlin'
    )
    expect(rehearsal).to be_valid
  end

  it 'can be read by the user to whom this rehearsal belongs' do
    should belong_to(:user)
  end

  context 'classic Active Record instance methods' do
    it 'returns an exercises id' do
      exercise = FactoryBot.create(:exercise, rehearsals: [rehearsal], questions: [question])
      expect(rehearsal.exercise_id).to eq(exercise.id)
    end

    it 'returns a users id' do
      normal_user = FactoryBot.create(:user, rehearsals: [rehearsal])
      expect(rehearsal.user_id).to eq(normal_user.id)
    end

    it 'returns a city' do
      rehearsal = FactoryBot.create(:rehearsal, city: 'Paris')
      expect(rehearsal.city).to eq('Paris')
    end
  end
end
