require 'rails_helper'

RSpec.describe 'Tags', type: :system do
  let(:current_user) { FactoryBot.create(:user) }
  let(:question) { FactoryBot.create(:question) }
  it 'can fetch tags on global exercise' do
    seneca_tag = FactoryBot.create(:tag, name: 'Seneca')
    FactoryBot.create(:exercise, tags: [seneca_tag], general_description: 'Senecas Favorite Exercise', global: true, questions: [question])

    sign_in current_user
    visit "/tags/#{seneca_tag.name}"
    Exercise.tagged_with("#{seneca_tag.name}")

    expect(page).to have_content('Senecas Favorite Exercise')
  end

  it 'can fetch tags on private exercise, if it belongs to me' do
    marcus_tag = FactoryBot.create(:tag, name: 'Marcus')
    FactoryBot.create(:exercise, tags: [marcus_tag], general_description: 'Senecas Favorite Exercise', global: false, user: current_user, questions: [question])

    sign_in current_user
    visit "/tags/#{marcus_tag.name}"
    Exercise.tagged_with("#{marcus_tag.name}")

    expect(page).to have_content('Senecas Favorite Exercise')
  end

  it 'can fetch tags on quotations' do
    epictetus_tag = FactoryBot.create(:tag, name: 'Epictetus')
    FactoryBot.create(:quotation, tags: [epictetus_tag], passage: 'Lets be so Stoic.', title: 'Epictetus say')

    sign_in current_user
    visit "/tags/#{epictetus_tag.name}"
    Quotation.tagged_with("#{epictetus_tag.name}")

    expect(page).to have_content('Epictetus say')
  end

  it 'can fetch tags on doctrine' do
    rufus_tag = FactoryBot.create(:tag, name: 'Rufus')
    FactoryBot.create(:doctrine, tags: [rufus_tag], file_name: 'disciplines_intro')

    sign_in current_user
    visit "/tags/#{rufus_tag.name}"
    Doctrine.tagged_with("#{rufus_tag.name}")

    expect(page).to have_content('is that the three Disciplines structure the relationship of human Reason')
  end
end
