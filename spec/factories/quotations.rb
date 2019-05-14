FactoryBot.define do
  factory :quotation do
    title    { 'Title' }
    passage  { 'Passage' }
    publish { true }
  end

  trait :tag do
    after(:build) do |quotation|
      quotation.tags << create(:tag)
    end
  end
end
