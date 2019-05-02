FactoryBot.define do
  factory :exercise do
    user_id { 44 }
    title { 'Senecas Courage Walk' }
    general_description { 'Take a stroll with Seneca and beef up your courage.' }
    global { false }
  end
end
