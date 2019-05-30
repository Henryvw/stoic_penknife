require 'rails_helper'

RSpec.describe Tag, type: :model do
  it 'can be read by the user to whom this rehearsal belongs' do
    should have_many(:exercises).through(:exercise_taggings)
  end

  it 'can be read by the user to whom this rehearsal belongs' do
    should have_many(:quotations).through(:quotation_taggings)
  end

  it 'can be read by the user to whom this rehearsal belongs' do
    should have_many(:doctrines).through(:doctrine_taggings)
  end
end
