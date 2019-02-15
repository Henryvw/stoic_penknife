require 'rails_helper'

#Matthias: FactoryGirl, 3 core methods for building: create, build, and build_stubb. First use create to have most confidence. Build_stubb is less expensive as it does not save to the database. It creates a 'fake' id for the Model to talk to for associations etc.

#Elements of Model Tests, According to Everyday RSpec, 2017: 
#1. When instantiated with valid attributes, a model should be valid
#2. Data that fails validations should not be valid.
#3. Instance methods perform as expected.
#4. Class methods perform as expected.

describe Quotation, type: :model do

  #Setup i.e. FactoryGirl Works with this Model
  it 'has a valid factory' do
    #Given and When (In this case combined)
    fake_factory_girl_generated_quotation_object = FactoryGirl.build(:quotation)
    #Then
    expect(fake_factory_girl_generated_quotation_object).to be_valid
  end

  #1. When instantiated with valid attributes, a model should be valid
  #aka, testing the ability to save to the columns in the database along the lines of this model
  it 'persists a valid model object when given a title, passage and a published status' do
  end 
  #2. Data that fails validations should not be valid.
  #(Empty - bc there are no validations on this model)

  #3 Instance methods perform as expected. Starting with Simple Automatic ActiveRecord ones, of returning saved attributes
  it 'returns a title' do
    quotation = FactoryGirl.build(:quotation)
    subject { quotation.title }
    expect(subject).to eq 'Dankenliste'
  end

  it 'returns a passage' do
  end

  it 'returns boolean true/false whether published or not' do
  end

  #3.5 - Now Going In-Depth Into More Complex, Custom Instance Methods
  describe 'tag-related instance methods' do
    context 'find quotations given tag(s)' do
      it '#tagged_with - when given a particular tag, returns all quotations attached to it in the database' do
      end

      it '#find_quotations_by - when given a LIST of tags, find all quotations attached to all of the tags in the database' do
      end
    end

    context 'find tags given quotation(s)' do
      #Setup
      quotation = FactoryGirl.build(:quotation, :tag)
      tags = quotation.tags

      it 'has a valid factory' do
        expect(tags.first).to be_valid
      end

      it '#tag_list - when given a particular quotation, finds a list of all the TAGS associated with it' do
        expect(tag).to include("Roman")
      end

      it 'using ActiveRecord find_or_create! method creates or assigns tag(s) given when a quotation is created' do
      end
    end
  end
end
