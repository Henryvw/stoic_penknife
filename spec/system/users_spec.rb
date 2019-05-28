require 'rails_helper'

RSpec.describe 'Users', type: :system do
  let!(:normal_user) { FactoryBot.create(:user) }

  it 'can sign in' do
    visit root_path
    click_link 'Sign In'
    fill_in 'user_email', with: normal_user.email
    fill_in 'user_password', with: normal_user.password
    click_button 'Log in'

    expect(page).to have_content 'Signed in successfully.'
    expect(page).to have_http_status(:success)
  end

  it 'can sign out' do
    sign_in normal_user
    visit root_path
    click_link 'Sign Out'
    expect(page).to have_content 'Signed out successfully.'
    expect(page).to have_http_status(:success)
  end

  it 'can sign up' do
    visit root_path
    click_link 'Sign Up'
    fill_in 'user_email', with: 'a_new_stoic_is_born_today@gmail.com'
    fill_in 'user_password', with: 'new_password'
    fill_in 'user_password_confirmation', with: 'new_password'
    click_button 'Sign up to activate Stoic Penknife'
    expect(page).to have_content 'Welcome to Stoic Penknife!'
    expect(page).to have_http_status(:success)
  end

  it 'cannot register an email already taken' do
    visit root_path
    click_link 'Sign Up'

    expect do
      fill_in 'user_email', with: normal_user.email
      fill_in 'user_password', with: normal_user.password
      fill_in 'user_password_confirmation', with: normal_user.password
      click_button 'Sign up to activate Stoic Penknife'
      expect(page).to have_content 'Email has already been taken'
    end.to change(User, :count).by(0)
  end

  it 'must match the password in password confirmation' do
    visit root_path
    click_link 'Sign Up'

    expect do
      fill_in 'user_email', with: 'another_new_stoic@gmail.com'
      fill_in 'user_password', with: 'new_password'
      fill_in 'user_password_confirmation', with: 'whoops_this_passwords_different'
      click_button 'Sign up to activate Stoic Penknife'
      expect(page).to have_content 'Password confirmation doesn\'t match Password'
    end.to change(User, :count).by(0)
  end
end
