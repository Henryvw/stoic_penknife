require 'rails_helper'

RSpec.describe 'Quotations', type: :system do
  let(:user) { FactoryBot.create(:user) }

  describe 'Signed-out user can see a list (index) of quotations' do
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
  end

  describe 'Normal Signed-in user' do
    it 'cannot add or edit quotations' do
    end
  end

  describe 'Admin user creates a new quotation' do
    it 'can add quotations' do
    end

    it 'can add quotations' do
    end
  end
end
