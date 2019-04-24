require 'rails_helper'
require 'spec_helpers/create_exercise_steps'
require 'spec_helpers/user_steps'

describe Rehearsal, type: :model do
  before :each do
    create_exercise
    create_rehearsal
    create_e_question
    create_e_answer
  end

  it 'has a valid factory-esque (in this case custom) process for faking rehearsal objects' do
    expect(@rehearsal).to be_valid
  end

  it 'can be read by the user to whom this rehearsal belongs' do
    create_normal_user(37)
    expect(Rehearsal.where(user_id = "#{@normal_user.id}")).to exist
  end

  it "cannot be read by a user to whom this rehearsal does not belong" do
    create_normal_user(1)
    create_second_normal_user(473)
    create_rehearsal
    expect(Rehearsal.where(user_id: @second_user.id)).to be_empty
  end
end
