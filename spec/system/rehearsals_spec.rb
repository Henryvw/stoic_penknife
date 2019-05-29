require 'rails_helper'

RSpec.describe 'Rehearsals', type: :system do
  describe 'normal signed-in user' do
    let(:normal_user) { FactoryBot.create(:user) }
    let(:e_question) { FactoryBot.create(:e_question) }
    let(:exercise) { FactoryBot.create(:exercise, e_questions: [e_question], global: true) }
    let(:e_answer) { FactoryBot.create(:e_answer) }
    let(:rehearsal) { FactoryBot.create(:rehearsal, e_answers: [e_answer]) }

    it 'can read a rehearsal if it belongs to me' do
      e_answer = FactoryBot.create(:e_answer, answer: 'I learned to dance.')
      rehearsal = FactoryBot.create(:rehearsal, e_answers: [e_answer], exercise: exercise, user: normal_user)

      sign_in normal_user
      visit rehearsal_path(rehearsal.id)

      expect(page).to have_content('I learned to dance.')
    end

    it 'cannot read a rehearsal that belongs to another user' do
      second_normal_user = FactoryBot.create(:user)
      rehearsal = FactoryBot.create(:rehearsal, e_answers: [e_answer], exercise: exercise, user: second_normal_user)

      sign_in normal_user
      visit rehearsal_path(rehearsal.id)

      expect(page).to have_content('You are not authorized to access this page.')
    end

    it 'can capture and view the city in which I practiced my rehearsal' do
      e_answer = FactoryBot.create(:e_answer, answer: 'I learned to dance.')
      rehearsal = FactoryBot.create(:rehearsal, e_answers: [e_answer], exercise: exercise, user: normal_user, city: 'Moscow')

      sign_in normal_user
      visit rehearsal_path(rehearsal.id)

      expect(page).to have_content('Moscow')
    end

    it 'can see an index of my rehearsals' do
      first_e_answer = FactoryBot.create(:e_answer, answer: 'I learned to dance')
      second_e_answer = FactoryBot.create(:e_answer, answer: 'I learned to dance a 2nd time')
      third_e_answer = FactoryBot.create(:e_answer, answer: 'I learned to dance a 3rd time')
      e_answers = [first_e_answer, second_e_answer, third_e_answer]
      FactoryBot.create(:rehearsal, e_answers: e_answers, exercise: exercise, user: normal_user)

      sign_in normal_user
      visit exercise_path(exercise.id)

      expect(page).to have_content('I learned to dance')
      expect(page).to have_content('I learned to dance a 2nd time')
      expect(page).to have_content('I learned to dance a 3rd time')
    end

    it 'can see a city on the individual exercises rehearsal index' do
      e_answer = FactoryBot.create(:e_answer, answer: 'I learned to dance.')
      FactoryBot.create(:rehearsal, e_answers: [e_answer], exercise: exercise, user: normal_user, city: 'Moscow')

      sign_in normal_user
      visit exercise_path(exercise.id)

      expect(page).to have_content('Moscow')
    end

    it 'can create a rehearsal' do
      FactoryBot.create(:rehearsal, exercise: exercise, user: normal_user)

      sign_in normal_user
      visit exercise_path(exercise.id)

      click_link 'Rehearse this Exercise'
      find(id: 'rehearsal_e_answers_attributes0_e_question_id', visible: false).set('Rehearsal Answer to 1st Question')
      click_button "Finish Rehearsing #{exercise.title}"

      expect(page).to have_content('Rehearsal was successfully created.')
    end

    it 'can edit a rehearsal' do
      rehearsal = FactoryBot.create(:rehearsal, exercise: exercise, user: normal_user)

      sign_in normal_user
      visit rehearsal_path(rehearsal.id)

      click_link 'Edit This Rehearsal'
      find(id: "edit_rehearsal_#{rehearsal.id}", visible: false).set('Edit this rehearsals first question')
      click_button "Finish Rehearsing #{exercise.title}"

      expect(page).to have_content('Rehearsal was successfully updated.')
    end

    it 'can delete a rehearsal' do
      rehearsal = FactoryBot.create(:rehearsal, exercise: exercise, user: normal_user)

      sign_in normal_user
      visit rehearsal_path(rehearsal.id)
      click_link 'Edit This Rehearsal'
      expect do
        click_link 'Delete This Rehearsal'
      end.to change(Rehearsal, :count).by(-1)
    end
  end
end
