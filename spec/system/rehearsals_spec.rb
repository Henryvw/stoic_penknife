require 'rails_helper'

RSpec.describe 'Rehearsals', type: :system do
  describe 'normal signed-in user' do
    let(:normal_user) { FactoryBot.create(:user) }
    let(:question) { FactoryBot.create(:question) }
    let(:exercise) { FactoryBot.create(:exercise, questions: [question], global: true) }
    let(:answer) { FactoryBot.create(:answer) }
    let(:rehearsal) { FactoryBot.create(:rehearsal, answers: [answer]) }

    it 'can read a rehearsal if it belongs to me' do
      answer = FactoryBot.create(:answer, reply: 'I learned to dance.')
      rehearsal = FactoryBot.create(:rehearsal, answers: [answer], exercise: exercise, user: normal_user)

      sign_in normal_user
      visit rehearsal_path(rehearsal.id)

      expect(page).to have_content('I learned to dance.')
    end

    it 'cannot read a rehearsal that belongs to another user' do
      second_normal_user = FactoryBot.create(:user)
      rehearsal = FactoryBot.create(:rehearsal, answers: [answer], exercise: exercise, user: second_normal_user)

      sign_in normal_user
      visit rehearsal_path(rehearsal.id)

      expect(page).to have_content('You are not authorized to access this page.')
    end

    it 'can capture and view the city in which I practiced my rehearsal' do
      answer = FactoryBot.create(:answer, reply: 'I learned to dance.')
      rehearsal = FactoryBot.create(:rehearsal, answers: [answer], exercise: exercise, user: normal_user, city: 'Moscow')

      sign_in normal_user
      visit rehearsal_path(rehearsal.id)

      expect(page).to have_content('Moscow')
    end

    it 'can see an index of my rehearsals' do
      first_answer = FactoryBot.create(:answer, reply: 'I learned to dance')
      second_answer = FactoryBot.create(:answer, reply: 'I learned to dance a 2nd time')
      third_answer = FactoryBot.create(:answer, reply: 'I learned to dance a 3rd time')
      answers = [first_answer, second_answer, third_answer]
      FactoryBot.create(:rehearsal, answers: answers, exercise: exercise, user: normal_user)

      sign_in normal_user
      visit exercise_path(exercise.id)

      expect(page).to have_content('I learned to dance')
      expect(page).to have_content('I learned to dance a 2nd time')
      expect(page).to have_content('I learned to dance a 3rd time')
    end

    it 'can see a city on the individual exercises rehearsal index' do
      answer = FactoryBot.create(:answer, reply: 'I learned to dance.')
      FactoryBot.create(:rehearsal, answers: [answer], exercise: exercise, user: normal_user, city: 'Moscow')

      sign_in normal_user
      visit exercise_path(exercise.id)

      expect(page).to have_content('Moscow')
    end

    it 'can create a rehearsal' do
      FactoryBot.create(:rehearsal, exercise: exercise, user: normal_user)
      sign_in normal_user
      visit exercise_path(exercise.id)

      click_link 'Practice It'
      find(id: 'rehearsal_answers_attributes0_question_id', visible: false).set('Rehearsal Answer to 1st Question')
      click_button "Finish My Practice of #{exercise.title}"

      expect(page).to have_content("You just practiced #{exercise.title}. Great job.")
    end

    it 'can edit a rehearsal' do
      rehearsal = FactoryBot.create(:rehearsal, exercise: exercise, user: normal_user)

      sign_in normal_user
      visit rehearsal_path(rehearsal.id)

      click_link 'Edit This Rehearsal'
      find(id: "edit_rehearsal_#{rehearsal.id}", visible: false).set('Edit this rehearsals first question')
      click_button "Finish My Practice of #{exercise.title}"

      expect(page).to have_content("You just updated your earlier practice of #{exercise.title}")
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
