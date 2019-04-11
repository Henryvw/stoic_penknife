def create_normal_user(id)
  @normal_user = User.new
  @normal_user.id = id
  @normal_user.admin = false
  @normal_user.email = 'henry_normal_user@gmail.com'
  @normal_user.password = 'feastoftheepiphany'
  @normal_user.save!
end

def sign_in_as_normal_user
  create_normal_user(1)
  visit new_user_session_path
  fill_in 'user_email', with: 'henry_normal_user@gmail.com'
  fill_in 'user_password', with: 'feastoftheepiphany'
  click_button 'Log in'
end

def create_admin_user
  @admin_user = User.new
  @admin_user.admin = true
  @admin_user.email = 'henry_admin@gmail.com'
  @admin_user.password = 'saintfrancis'
  @admin_user.save!
end

def sign_in_as_admin
  create_admin_user
  visit new_user_session_path
  fill_in 'user_email', with: 'henry_admin@gmail.com'
  fill_in 'user_password', with: 'saintfrancis'
  click_button 'Log in'
end

def flag_it_as_global
  check 'exercise[global]'
  fill_in 'exercise_title', with: @exercise.user_id
  click_button 'Save Exercise'
  save_and_open_page
end
