require 'rails_helper'

RSpec.describe 'Quotations', type: :system do
  let(:user) { FactoryBot.create(:user) }

  describe 'Signed-out user can see a list (index) of quotations' do
    it 'can see a list (index) of quotations' do
      quotation = FactoryBot.create(:quotation, title: 'Goethe Love', passage: 'Die Menschheit.')
      visit quotations_path

      expect(page).to have_content 'Goethe Love'
    end
  end

  describe 'Admin user creates a new quotation' do
  end
end
