require 'rails_helper'

describe Doctrine, type: :model do
  before(:all) do
    @doctrine = FactoryBot.create(:doctrine, :tag)
    @tags = @doctrine.tags
  end

  it 'has a valid factory' do
    fake_factory_bot_generated_doctrine_object = FactoryBot.build(:doctrine)
    fake_factory_bot_generated_tag_object = FactoryBot.build(:tag)

    expect(fake_factory_bot_generated_doctrine_object).to be_valid
    expect(fake_factory_bot_generated_tag_object).to be_valid
    expect(@tags.first).to be_valid
  end

  it 'persists a valid model object when given a file_name and a published boolean' do
    doctrine = Doctrine.new(
      file_name: 'nur_wo_graeber_sind',
      publish: false
    )

    expect(doctrine).to be_valid
  end

  context 'classic ActiveRecord instance methods' do
    it 'returns a file_name' do
      expect(@doctrine.file_name).to eq 'hadot_marcus_aurelius'
    end

    it 'returns boolean true/false whether published or not' do
      expect(@doctrine.publish).to eq true
    end
  end

  describe 'Custom methods, mostly tag methods' do
    context 'find doctrines given tag(s)' do
      it '#tagged_with - when given a particular tag, returns all doctrines attached to it in the database' do
        expect(Doctrine.tagged_with('Roman').first.file_name).to eq('hadot_marcus_aurelius')
      end

      it '#find_quotations_with - when given a LIST of tags, find all doctrines attached to all of the tags in the database' do
        expect(Doctrine.find_doctrines_with(@tags).first.file_name).to eq('hadot_marcus_aurelius')
      end

    end

    context 'find tags given doctrine(s)' do
      it '#tag_list - when given a particular doctrine, finds a list of all the TAGS associated with it' do
        expect(@doctrine.tag_list).to include('Roman')
      end

      it 'using ActiveRecord find_or_create! method creates or assigns tag(s) given when a doctrine is created' do
        @doctrine.tag_list = 'Phoenician Wisdom'
        expect(@doctrine.tag_list).to include('Phoenician Wisdom')
      end
    end
  end
end
