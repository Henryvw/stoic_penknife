require 'rails_helper'

RSpec.describe 'Exercises', type: :system do
include ActionDispatch::TestProcess::FixtureFile
include Rack::Test::Methods
  describe 'non-logged-in (guest) user' do
include Rack::Test::Methods
include ActionDispatch::TestProcess::FixtureFile
    let(:question) { FactoryBot.create(:question) }
    let(:exercise) { FactoryBot.create(:exercise, questions: [question], global: true) }

    it 'can read a global exercise' do
      FactoryBot.create(:exercise, questions: [question], global: true, general_description: 'Senecas Amazing Exercise.')
      visit exercises_path
      expect(page).to have_content('Senecas Amazing Exercise')
    end

    it 'can read the exercise index - with global exercises' do
      exercise = FactoryBot.create(:exercise, questions: [question], global: true, general_description: 'Senecas Amazing Exercise.')
      visit exercise_path(exercise.id)
      expect(page).to have_content('Senecas Amazing Exercise')
    end

    it 'cannot read a private exercise' do
      other_user = FactoryBot.create(:user)
      someones_private_exercise = FactoryBot.create(:exercise, questions: [question], global: false, general_description: 'Senecas Amazing Exercise.', user: other_user)
      visit exercise_path(someones_private_exercise.id)
      expect(page).to have_content('You are not authorized to access this page')
    end

    it 'can read the buzzwords on the exercises index page' do
      FactoryBot.create(:exercise, questions: [question], global: true, general_description: 'Senecas Amazing Exercise.', buzzword: 'Great for after a break-up')
      visit exercises_path
      expect(page).to have_content('Great for after a break-up')
    end

    it 'can see the latest exercise on the index page' do
      FactoryBot.create(:exercise, questions: [question], global: true)
      latest_exercise = FactoryBot.create(:exercise, questions: [question], global: true, general_description: 'Here is the latest exercise.')
      visit exercises_path
      expect(page).to have_content('Here is the latest exercise.')
      expect(Exercise.where(global: true).last).to eq(latest_exercise)
    end

    it 'can see the special tag on the individual exercise show page' do
      exercise = FactoryBot.create(:exercise, questions: [question], global: true, general_description: 'Senecas Amazing Exercise.')
      visit exercise_path(exercise.id)
      expect(page).to have_content('Senecas Amazing Exercise')
    end

    it 'can see the active storage image on the individual exercise show page' do
      include ActionDispatch::TestProcess::FixtureFile
      exercise = FactoryBot.create(:exercise, :with_icon, global: true, questions: [question])
      visit exercise_path(exercise.id)
      expect(page).to have_css("img[src*='test-image.jpg']")
    end
  end

  describe 'normal signed-in user' do
include ActionDispatch::TestProcess::FixtureFile
    let(:normal_user) { FactoryBot.create(:user) }
    let(:question) { FactoryBot.create(:question) }
    let(:exercise) { FactoryBot.create(:exercise, questions: [question], global: true) }

    it 'can read a private exercise if it belongs to me' do
      FactoryBot.create(:exercise, questions: [question], global: false, general_description: 'Senecas Amazing Exercise.', user: normal_user)

      sign_in normal_user
      visit exercises_path

      expect(page).to have_content('Senecas Amazing Exercise')
    end

    it 'can read a global exercise, even if it belongs to someone else' do
      second_normal_user = FactoryBot.create(:user)
      exercise = FactoryBot.create(:exercise, questions: [question], global: true, general_description: 'Senecas Amazing Exercise.', user: normal_user)

      sign_in second_normal_user
      visit exercise_path(exercise.id)

      expect(page).to have_content('Senecas Amazing Exercise')
    end

    it 'can see the active storage image on the individual exercise show page' do
      exercise = FactoryBot.create(:exercise, :with_icon, global: true, questions: [question])
      visit exercise_path(exercise.id)
      expect(page).to have_css("img[src*='test-image.jpg']")
    end

    it 'can create an exercise' do
      sign_in normal_user
      visit exercises_path

      click_link 'Create New Custom Exercise'
      fill_in 'Title', with: 'Fake Exercise Title'
      fill_in 'General description', with: 'Fake Exercise Description'
      fill_in 'exercise_tag_list', with: 'Fake Tag'
      attach_file('exercise_icon', 'spec/support/assets/test-image.jpg')

      # From Capybara Docs:
      # 'fill_in(locator, options = {}) => Object'
      # 'Locate a text field or text area and fill it in with the given text The field can be found via its name, id or label text.'
      # The page.html is sometimes missing the name, id or label as Capybara sees it (why? I don't know). In this case I found in
      # the browser the name of the form group (note that it was HIGHER in the DOM tree, the form GROUP rather than some hidden
      # lower element. I don't know whether that's relevant / easier for Capybara to find) that I was looking for,
      # exercise[questions_attributes][0][question]

      fill_in 'exercise[questions_attributes][0][inquiry]', with: 'Fake Exercise Question #1'
      fill_in 'exercise[questions_attributes][1][inquiry]', with: 'Fake Exercise Question #2'
      fill_in 'exercise[questions_attributes][2][inquiry]', with: 'Fake Exercise Question #3'

      expect do
        click_button 'Save Exercise'
        expect(page).to have_content('Exercise was successfully created.')

        expect(ActiveStorage::Attachment.count).to eq(1)
      end.to change(Exercise, :count).by(1)

      expect(ActiveStorage::Attachment.count).to eq(1)
    end

    # Note js: true below, for 'Add new question' and 'Remove/delete question'.
    # The 'New Question' and 'Remove Question' buttons (links) use Javascript to add a new question element to the page.
    # Therefore you need to activate the selenium chrome headless web driver-linked capybara. (See Capybara config).
    it 'can add a question when creating/editing an exercise', js: true do
      sign_in(normal_user)
      visit exercises_path
      click_link 'Create New Custom Exercise'

      fill_in 'Title', with: 'Fake Exercise Title'
      fill_in 'General description', with: 'Fake Exercise Description'
      fill_in 'exercise_tag_list', with: 'Fake Tag'
      fill_in 'exercise[questions_attributes][0][inquiry]', with: 'Fake Exercise Question #1'
      fill_in 'exercise[questions_attributes][1][inquiry]', with: 'Fake Exercise Question #2'
      fill_in 'exercise[questions_attributes][2][inquiry]', with: 'Fake Exercise Question #3'

      click_link 'Add New Question'
      all(:field).last.set('NEW Fake Exercise Question')
      click_button 'Save Exercise'

      expect(page).to have_content('Exercise was successfully created.')
      expect(page).to have_content('NEW Fake Exercise Question')
    end

    it 'can delete a question when creating/editing an exercise', js: true do
      second_question = FactoryBot.create(:question)
      exercise = FactoryBot.create(:exercise, questions: [question, second_question], global: false, general_description: 'Senecas Amazing Exercise.', user: normal_user)
      sign_in normal_user
      visit exercise_path(exercise.id)
      click_link 'Edit'
      all(:field).last.set('Question to DELETE')
      page.all('div', text: 'Remove').last.click_link('Remove')
      click_link 'Add New Question'
      all(:field).last.set('Fake Exercise Question #1')

      click_button 'Save Exercise'

      expect(page).to have_content('Exercise was successfully updated.')
      expect(page).to_not have_content('Question to DELETE')
    end

    it 'can edit an exercise' do
      exercise = FactoryBot.create(:exercise, questions: [question], global: false, general_description: 'Senecas Amazing Exercise.', user: normal_user)
      sign_in normal_user
      visit exercise_path(exercise.id)

      click_link 'Edit'
      fill_in 'exercise[questions_attributes][0][inquiry]', with: 'EDITED Question'
      click_button 'Save Exercise'

      expect(page).to have_content('Exercise was successfully updated.')
      expect(page).to have_content('EDITED Question')
    end

    it 'can delete an exercise' do
      exercise = FactoryBot.create(:exercise, questions: [question], global: false, general_description: 'Senecas Amazing Exercise.', user: normal_user)
      sign_in normal_user
      visit exercise_path(exercise.id)

      expect do
        click_link 'Delete'
      end.to change(Exercise, :count).by(-1)
    end

    it 'cannot flag an exercise as global' do
      exercise = FactoryBot.create(:exercise, questions: [question], global: false, general_description: 'Senecas Amazing Exercise.', user: normal_user)
      sign_in normal_user
      visit exercise_path(exercise.id)
      click_link 'Edit'

      expect(page).to_not have_content('Publish this exercise globally')
    end
  end

  it 'cannot see its own table of rehearsals if it hasnt practiced the exercise yet' do
    normal_user = FactoryBot.create(:user)
    question = FactoryBot.create(:question)
    exercise = FactoryBot.create(:exercise, questions: [question], global: false, general_description: 'Senecas Amazing Exercise.', user: normal_user)
    sign_in normal_user
    visit exercise_path(exercise.id)

    expect(page).to_not have_content('My Past Practice')
  end

  it 'can see its table of rehearsals if it has practiced the exercise' do
    normal_user = FactoryBot.create(:user)
    question = FactoryBot.create(:question)
    FactoryBot.create(:exercise, questions: [question], global: false, general_description: 'Senecas Amazing Exercise.', user: normal_user)
    exercise = FactoryBot.create(:exercise, questions: [question], global: false, general_description: 'Senecas Amazing Exercise.', user: normal_user)
    sign_in normal_user
    answer = FactoryBot.create(:answer, reply: 'I learned to dance.')
    FactoryBot.create(:rehearsal, answers: [answer], exercise: exercise, user: normal_user)
    visit exercise_path(exercise.id)

    expect(page).to have_content('I learned to dance.')
  end

  describe 'admin user' do
    let(:admin_user) { FactoryBot.create(:user, admin: true) }
    let(:question) { FactoryBot.create(:question) }
    let(:exercise) { FactoryBot.create(:exercise, questions: [question], global: true) }
    it 'can publish an exercise globally' do
      sign_in admin_user
      visit new_exercise_path

      fill_in 'Title', with: 'Fake Exercise Title'
      fill_in 'General description', with: 'Fake Exercise Description'

      fill_in 'exercise[questions_attributes][0][inquiry]', with: 'Fake Exercise Question #1'

      find_by_id('exercise_global').set(true)

      click_button 'Save Exercise'
      expect(page).to have_content('Stoic Think-Exercises')
    end
  end
end
