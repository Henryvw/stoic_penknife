require 'rails_helper'

RSpec.describe 'Quotations', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:admin_user) { FactoryBot.create(:user, admin: true) }

  describe 'Signed-out user' do
    it 'can see a list (index) of quotations' do
      FactoryBot.create(:quotation, title: 'Goethe Love', passage: 'Die Menschheit.')
      visit quotations_path

      expect(page).to have_content 'Goethe Love'
    end

    it 'cannot edit quotations' do
      quotation = FactoryBot.create(:quotation)
      visit edit_quotation_path(quotation.id)
      expect(page).to have_content 'You are not authorized to access this page'
    end

    it 'cannot add quotations' do
      visit new_quotation_path
      expect(page).to have_content 'You are not authorized to access this page'
    end
  end

  describe 'Normal Signed-in user' do
    it 'can see a list (index) of quotations' do
      sign_in user
      FactoryBot.create(:quotation, title: 'Goethe Love', passage: 'Die Menschheit.')
      visit quotations_path
      expect(page).to have_content 'Goethe Love'
    end

    it 'cannot add quotations' do
      sign_in user
      visit new_quotation_path
      expect(page).to have_content 'You are not authorized to access this page'
    end

    it 'cannot edit quotations' do
      sign_in user
      quotation = FactoryBot.create(:quotation, title: 'Goethe Love', passage: 'Die Menschheit.')
      visit edit_quotation_path(quotation.id)
      expect(page).to have_content 'You are not authorized to access this page'
    end
  end

  describe 'Admin user' do
    it 'can see a list (index) of quotations' do
      FactoryBot.create(:quotation, title: 'Goethe Love', passage: 'Die Menschheit.')
      sign_in admin_user
      visit quotations_path
      expect(page).to have_content 'Goethe Love'
    end

    it 'can add quotations' do
      sign_in admin_user
      visit quotations_path
      expect do
        click_link 'New Quotation'
        fill_in 'Title', with: 'Test Quote Title'
        fill_in 'Passage', with: 'Test Quote Passage'
        click_button 'Save'

        aggregate_failures do
          expect(page).to have_content 'New quotation added!'
          expect(page).to have_content 'Test Quote Title'
          expect(page).to have_content 'Test Quote Passage'
        end
      end.to change(Quotation, :count).by(1)
    end

    it 'can edit quotations' do
      sign_in admin_user
      FactoryBot.create(:quotation, title: 'Goethe HATE', passage: 'Die Menschheit.')

      visit quotations_path

      # Find is really cool - You can CHAIN finds and find WITHIN finds:
      # like the human eye, moving ever inward into HTML elements to find what you are looking for.
      find('tr', text: 'Goethe HATE').click_link('Edit')
      fill_in 'Title', with: 'EDITED Quote Title'
      fill_in 'Passage', with: 'EDITED Quote Passage'
      click_button 'Save'

      aggregate_failures do
        expect(page).to have_content 'Quotation was successfully updated.'
        expect(page).to have_content 'EDITED Quote Title'
        expect(page).to have_content 'EDITED Quote Passage'
      end
    end
  end
end
