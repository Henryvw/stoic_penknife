require 'rails_helper'

RSpec.describe Tag, type: :model do
  it 'can be read by the user to whom this rehearsal belongs' do
    should have_many(:exercises).through(:taggings)
  end

  it 'can be read by the user to whom this rehearsal belongs' do
    should have_many(:quotations).through(:taggings)
  end

  it 'can be read by the user to whom this rehearsal belongs' do
    should have_many(:doctrines).through(:taggings)
  end
end
