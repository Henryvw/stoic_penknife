# frozen_string_literal: true

FactoryBot.define do
  factory :quotation do
    title    { 'Aurelius Dankenliste' }
    passage  { 'Von ruhmvollen Andenken meines Vaters erhielt ich den Antrieb zu einem bescheidenen und zugleich männlichen Wesen.' }
    publish {  true }
  end

  trait :tag do
    after(:build) do |quotation|
      quotation.tags << create(:tag, name: 'Roman')
    end
  end
end

# Something here isn't working due to the has_many through relationship and setting up of the Factory... there is a blog post at http://nepalonrails.com/blog/2014/09/factory-girl-traits-and-list-for-has-many-through-relation that shows an example of how it should work... otherwise just google "has many through FactoryBot" and there are lots of solutions. I am tired now, I think I am just doing something small wrong here... It really should just work out of the box. I mean it is just a has_many through relationship and FactoryBot through its advanced associations should just be able to test that normally.
#
