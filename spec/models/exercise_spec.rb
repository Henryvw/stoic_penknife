require 'rails_helper'

RSpec.describe Exercise, type: :model do
  let(:current_user) { FactoryBot.create(:user) }
  let(:exercise) { FactoryBot.create(:exercise, user: current_user) }

  describe 'Validation - Basic Setup of Testing' do
    it 'has a valid factory' do
      expect(exercise).to be_valid
    end

    it 'persists a valid model object when given strings for title, general description, user id and a global boolean' do
      exercise = Exercise.new(
        title: 'Senecas Dance with Dragons',
        general_description: 'An amazing exercise to really get your pants off.',
        user: current_user
      )
    end
  end

  describe 'Attributes - Classic ActiveRecord Instance Methods' do
    it 'returns a title' do
      exercise = FactoryBot.create(:exercise, title: 'Senecas Courage Walk')
      expect(exercise.title).to eq('Senecas Courage Walk')
    end

    it 'returns a general description' do
      exercise = FactoryBot.create(:exercise, general_description: 'Take a stroll with Seneca and beef up your courage.')
      expect(exercise.general_description).to eq('Take a stroll with Seneca and beef up your courage.')
    end

    it 'returns a global boolean' do
      exercise = FactoryBot.create(:exercise, global: false)
      expect(exercise.global?).to eq(false)
    end
  end

  # Henry's custom methods
  describe '#rehearsals_for_user' do
    it 'successfully fetches all rehearsals for that particular exercise for that particular user' do
      user = FactoryBot.build_stubbed(:user)
      #exercise = FactoryBot.create(:exercise, :socrates_tag)
      rehearsal = FactoryBot.create(:rehearsal, exercise: exercise, user: user)

      actual = exercise.rehearsals_for_user(user)

      expected = [rehearsal]
      expect(actual).to eq(expected)
    end

    it 'does not fetch other users rehearsals' do
      user = FactoryBot.build_stubbed(:user)
      user_two = FactoryBot.build_stubbed(:user)
      #exercise = FactoryBot.create(:exercise)
      rehearsal = FactoryBot.create(:rehearsal, exercise: exercise, user: user_two)

      actual = exercise.rehearsals_for_user(user)

      expect(actual).to_not include(rehearsal)
    end
  end

  describe '#self.tagged_with (find EXERCISE with this tag)' do
    it 'returns an exercise when given a tag associated with it' do
      exercise = FactoryBot.create(:exercise, :socrates_tag)
      expect(Exercise.tagged_with('Socrates').first.title).to eq('Senecas Courage Walk')
    end
  end

  describe '#tag_list (getter - find TAGS linked to this exercise)' do
    it 'returns an exercise when given a tag associated with it' do
      exercise = FactoryBot.create(:exercise, :aristotle_tag)
      expect(exercise.tag_list).to include('Aristotle')
    end
  end

  describe '#tag_list= (setter)' do
    it 'sets a tag' do
      exercise.tag_list='Aristarchus'
      expect(exercise.tag_list).to include('Aristarchus')
    end
  end

  describe '#maximum_number_of_questions' do
    it 'validates to prevent more than 7 questions' do
      exercise = Exercise.new(
        title: 'Senecas Dance with Dragons',
        general_description: 'An amazing exercise to really get your pants off.',
        user: current_user,
      )

      8.times { exercise.e_questions.build(question: "Why?") }

      exercise.valid?
      expect(exercise.errors[:base]).to include('You may only add a max of 7 questions.')
    end
  end
end
