require 'rails_helper'
require 'capybara/rails'
require 'spec_helpers/create_exercise_steps'
require 'spec_helpers/user_steps'

RSpec.feature 'Normal User Manages Exercise' do
  before :each do
    sign_in_as_normal_user
    create_exercise
    set_exercise_owned_by_normal_user
  end

  scenario 'New Exercise created' do
    check_if_exercise_created
  end

  scenario 'Exercise should be local' do
    visit_exercise_page
    check_if_exercise_is_local
  end

  scenario 'User CANNOT flag Exercise as Global' do
    visit_exercise_page
    check_that_edit_exercise_link_is_removed
  end

  def check_if_exercise_created
    expect(@exercise.id?).to eq true
  end

  def check_if_exercise_is_local
    expect(page).to have_content 'Custom Exercise'
  end

  def check_that_edit_exercise_link_is_removed
    expect(page).not_to have_content 'Edit Exercise'
  end
end

# NEXT STEP: Now check a few more things, like, that one user cannot edit another user's exercise, assuming that it's local. (Maybe this is more of a unit or integration test. Also... well just think more about what you are testing. I think you also need to test like, both global and local exercises, against both admin and normal user.
#
