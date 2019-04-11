require 'rails_helper'
require 'spec_helpers/create_exercise_steps'
require 'spec_helpers/user_steps'

describe Rehearsal do
  before :each do
    create_exercise
    create_rehearsal
    create_e_question
    create_e_answer
    create_normal_user(1)
  end
  it 'can be read by the user to whom this rehearsal belongs' do
    expect(Rehearsal.where(user_id = @normal_user.id)).to exist
  end

  #  it "cannot be read by a user to whom this rehearsal does not belong" do
  #    create_normal_user(2)
  #    create_rehearsal
  #    expect(Rehearsal.where(user_id=@normal_user.id).first.user_id).not_to exist
  #  end
end
