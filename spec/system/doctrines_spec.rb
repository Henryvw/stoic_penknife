require 'rails_helper'

RSpec.describe 'Doctrines', type: :system do
  describe 'Signed-out user' do
    it 'can see a list (index) of doctrines' do
      visit '/doctrines'
      expect(page).to have_content 'Discipline of Assent'
      expect(page).to have_content 'Discipline of Desire'
      expect(page).to have_content 'Discipline of Action'
    end

    it 'can visit an individual custom-route doctrine show page' do
      visit '/doctrines_assent'
      expect(page).to have_content 'Theory of Representation, Judgement and Assent'
    end

    it 'cannot create new doctrines' do
      visit doctrines_new_path
      expect(current_path).to eql('/')
      expect(page).to have_content 'You are not authorized to access this page'
    end
  end

  describe 'Signed-in user' do
    let(:normal_user) { FactoryBot.create(:normal_user, admin: false) }

    it 'cannot create new doctrines' do
      visit doctrines_new_path
      expect(current_path).to eql('/')
      expect(page).to have_content 'You are not authorized to access this page'
    end
  end

  describe 'Admin user' do
    let(:admin_user) { FactoryBot.create(:user, admin: true) }

    it 'can create a new doctrine when filled out correctly' do
      sign_in admin_user
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
