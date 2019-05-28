require 'rails_helper'

RSpec.describe 'Doctrines', type: :system do
  describe 'Signed-out user' do
    it 'can see a list (index) of doctrines' do
      visit doctrines_path
      expect(page).to have_content 'What Is Stoic Penknife?'
    end
  end

  describe 'Normal Signed-in user' do
    let(:current_user) { FactoryBot.create(:user) }

    it 'can see a particular doctrine page' do
      sign_in current_user
      visit doctrines_action_path
      expect(page).to have_content 'What Is Stoic Penknife?'
    end
  end

  describe 'Admin user' do
    let(:admin_user) { FactoryBot.create(:user, admin: true) }

    it 'can see a list (index) of doctrines' do
      sign_in admin_user
      visit doctrines_action_path
      expect(page).to have_content 'What Is Stoic Penknife?'
    end

    it 'can create a new doctrine' do
      sign_in admin_user
      FactoryBot.create(:doctrine)
      doctrine_params = FactoryBot.attributes_for(:doctrine, file_name: 'goethe_love', tag_list: 'faust')

      visit doctrines_new_path

      expect do
        fill_in 'doctrine_file_name', with: doctrine_params[:file_name]
        fill_in 'doctrine_tag_list', with: doctrine_params[:tag_list]

        click_button 'Save'

        expect(page).to have_http_status(:success)
      end.to change(Doctrine, :count).by(1)
    end
  end
end
