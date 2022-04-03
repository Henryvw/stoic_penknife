FactoryBot.define do
  factory :exercise do
    title { 'Title' }
    general_description { 'General Description' }
    global { false }
  end

  trait :socrates_tag do
    after(:build) do |exercise|
      exercise.tags << create(:tag, name: 'Socrates')
    end
  end

  trait :aristotle_tag do
    after(:build) do |exercise|
      exercise.tags << create(:tag, name: 'Aristotle')
    end
  end

  trait :heraklitus_tag do
    after(:build) do |exercise|
      exercise.tags << create(:tag, name: 'Heraklitus')
    end
  end

  trait :question do
    after(:build) do |exercise|
      exercise.questions << create(:question, question: 'Question?')
    end
  end

  trait :with_icon do
    after(:build) do |exercise|
      file_path = Rails.root.join('spec', 'support', 'assets', 'test-image.jpg')
      file = Rack::Test::UploadedFile.new(Rails.root.join(file_path))
      exercise.icon.attach(file)
    end
  end
end
