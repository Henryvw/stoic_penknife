require 'rails_helper'
require 'spec_helpers/create_exercise_steps'

describe EQuestion do
  before :each do
    create_exercise
    create_e_question
    create_e_answer
  end

  it 'returns an exercise question as a string' do
    expect(@e_question.question). to eq 'Do you practice the Discipline of Assent?'
  end

  it 'can be accessed via an e_question'
  it 'can be accessed via a rehearsal, since it is a nested attribute of rehearsal via e_question'
end
