require 'rails_helper'
require 'spec_helpers/create_exercise_steps'
require 'spec_helpers/user_steps'

describe Rehearsal, type: :model do
  before :each do
    create_normal_user
    create_exercise
    create_rehearsal
    create_e_question
    create_e_answer
  end

  it 'has a valid factory-esque (in this case custom) process for faking rehearsal objects' do
    expect(@rehearsal).to be_valid
  end

  it 'persists a valid model object when given an exercise_id, a user_id and a city.' do
    rehearsal = Rehearsal.new(
      exercise_id: @exercise.id,
      user_id: @normal_user.id,
      city: "Berlin"
    )
    expect(rehearsal).to be_valid
  end

  it 'can be read by the user to whom this rehearsal belongs' do
    expect(Rehearsal.where(user_id = "#{@normal_user.id}")).to exist
  end

  it "cannot be read by a user to whom this rehearsal does not belong" do
    create_normal_user(55)
    create_second_normal_user(473)
    create_rehearsal
    expect(Rehearsal.where(user_id: @second_user.id)).to be_empty
  end

  context 'classic Active Record instance methods' do
    it 'returns an exercises id' do
      expect(@rehearsal.exercise_id).to eq(@exercise.id)
    end

    it 'returns a users id' do
      expect(@rehearsal.user_id).to eq(@normal_user.id)
    end

    it 'returns a city' do
      expect(@rehearsal.city).to eq('Berlin')
    end
  end
end
