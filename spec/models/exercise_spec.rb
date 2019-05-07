require 'rails_helper'

RSpec.describe Exercise, type: :model do
    let(:current_user) { FactoryBot.create(:user) }
    let(:exercise) { FactoryBot.create(:exercise, user_id: current_user.id) }

  # Basic Setup
  it 'has a valid factory' do
    expect(exercise).to be_valid
  end

  it 'persists a valid model object when given strings for title, general description, user id and a global boolean' do
    exercise = Exercise.new(
      title: 'Senecas Dance with Dragons',
      general_description: 'An amazing exercise to really get your pants off.',
      user_id: current_user.id
    )
  end

  # Classic ActiveRecord Instance Methods

  # Henry's custom methods
  describe '#rehearsals_for_user' do
    it 'successfully fetches all rehearsals for that particular exercise for that particular user' do
      user = FactoryBot.build_stubbed(:user)
      exercise = FactoryBot.create(:exercise)
      rehearsal = FactoryBot.create(:rehearsal, exercise: exercise, user: user)

      actual = exercise.rehearsals_for_user(user)

      expected = [rehearsal]
      expect(actual).to eq(expected)
    end

    it 'does not fetch other users rehearsals' do
      user = FactoryBot.build_stubbed(:user)
      user_two = FactoryBot.build_stubbed(:user)
      exercise = FactoryBot.create(:exercise)
      rehearsal = FactoryBot.create(:rehearsal, exercise: exercise, user: user_two)

      actual = exercise.rehearsals_for_user(user)

      expect(actual).to_not include(rehearsal)
    end
  end
end
