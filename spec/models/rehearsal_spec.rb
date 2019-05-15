require 'rails_helper'

describe Rehearsal, type: :model do
  let(:normal_user) { FactoryBot.create(:user) }
  let(:rehearsal) { FactoryBot.create(:rehearsal) }
  let(:exercise) { FactoryBot.create(:exercise) }

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
    # rubocop:disable Lint/UselessAssignment
    rehearsal = Rehearsal.where(user_id = normal_user.id.to_s)
    # rubocop:enable Lint/UselessAssignment
    expect(rehearsal).to exist
  end

  it 'cannot be read by a user to whom this rehearsal does not belong' do
    FactoryBot.create(:user, id: 55)
    second_normal_user = FactoryBot.create(:user, id: 473)
    expect(Rehearsal.where(user_id: second_normal_user.id)).to be_empty
  end

  context 'classic Active Record instance methods' do
    it 'returns an exercises id' do
      exercise = FactoryBot.create(:exercise, rehearsals: [rehearsal])
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
