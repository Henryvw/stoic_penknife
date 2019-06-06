require 'rails_helper'

RSpec.describe 'Exercises', type: :system do
  describe 'normal signed-in user' do
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

    it 'can create an exercise' do
      sign_in normal_user
      visit exercises_path

      click_link 'Create New Exercise'
      fill_in 'Title', with: 'Fake Exercise Title'
      fill_in 'General description', with: 'Fake Exercise Description'
      fill_in 'exercise_tag_list', with: 'Fake Tag'

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
      end.to change(Exercise, :count).by(1)
    end

    # Note js: true below, for 'Add new question' and 'Remove/delete question'.
    # The 'New Question' and 'Remove Question' buttons (links) use Javascript to add a new question element to the page.
    # Therefore you need to activate the selenium chrome headless web driver-linked capybara. (See Capybara config).
    it 'can add a question when creating/editing an exercise', js: true do
      sign_in normal_user
      visit new_exercise_path
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
      exercise = FactoryBot.create(:exercise, questions: [question], global: false, general_description: 'Senecas Amazing Exercise.', user: normal_user)
      sign_in normal_user
      visit exercise_path(exercise.id)
      click_link 'Edit Exercise'
      all(:field).last.set('Question to DELETE')
      page.all('div', text: 'Remove').last.click_link('Remove Question')
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

      click_link 'Edit Exercise'
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
        click_link 'Delete Exercise'
      end.to change(Exercise, :count).by(-1)
    end

    it 'cannot flag an exercise as global' do
      exercise = FactoryBot.create(:exercise, questions: [question], global: false, general_description: 'Senecas Amazing Exercise.', user: normal_user)
      sign_in normal_user
      visit exercise_path(exercise.id)
      click_link 'Edit Exercise'

      expect(page).to_not have_content('Publish this exercise globally')
    end
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
      expect(page).to have_content('Global Exercise')
    end
  end
end
