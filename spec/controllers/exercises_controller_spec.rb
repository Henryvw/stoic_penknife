require 'rails_helper'

RSpec.describe ExercisesController, type: :controller do
  describe '#show' do
    let(:user) { FactoryBot.build_stubbed(:user) }

    before do
      allow(controller).to receive(:authenticate_user!)
      allow(controller).to receive(:current_user).and_return(user)
    end

    it 'assigns the exercises ivar to the exercise for an id' do
      # Arrange, Act, Assert
      exercise = FactoryBot.create(:exercise)
      get :show, id: exercise.id
      exercise_ivar = assigns(:exercise)
      expect(exercise_ivar).to eq(exercise)
    end

    it 'raises an active record error if the exercise does not exist' do
      expect { get :show, id: 'invalid ID' }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'assigns the return value of exercise#rehearsals_for_user to the rehearsals ivar' do
      exercise = FactoryBot.create(:exercise)
      allow(Exercise).to receive(:find).with(exercise.id.to_s).and_return(exercise)

      rehearsals_for_user = double('rehearsals_for_user')
      allow(exercise).to receive(:rehearsals_for_user).with(user).and_return(rehearsals_for_user)

      get :show, id: exercise.id
      rehearsals_ivar = assigns(:rehearsals)

      expect(rehearsals_ivar).to eq(rehearsals_for_user)
    end

    context 'when the exercise has no tags' do
      it 'doctrines ivar is nil' do
        exercise = FactoryBot.create(:exercise)

        get :show, id: exercise.id
        doctrines_ivar = assigns(:doctrines)

        expect(doctrines_ivar).to be_nil
      end
    end

    context 'when the exercise has tags' do
      it 'tags ivar is set to the exercises ivars tags' do
        exercise = FactoryBot.create(:exercise)
        tag = FactoryBot.create(:tag)
        exercise_tagging = FactoryBot.create(:exercise_tagging, exercise: exercise, tag: tag)
        exercise_tags = [tag]

        get :show, id: exercise.id
        tags_ivar = assigns(:tags)

        expect(tags_ivar).to eq(exercise_tags)
      end

      context 'when the first tag associated with an exercise has no doctrines' do
        it 'sets the doctrines ivar to be empty' do
          exercise = FactoryBot.create(:exercise)
          tag = FactoryBot.create(:tag)
          exercise_tagging = FactoryBot.create(:exercise_tagging, exercise: exercise, tag: tag)

          get :show, id: exercise.id
          doctrines_ivar = assigns(:doctrines)

          expect(doctrines_ivar).to be_empty
        end
      end

      context 'when the first tag associated with an exercise has doctrines' do
        it 'sets the doctrines ivar to the doctrines associated with the first tag' do
          exercise = FactoryBot.create(:exercise)
          tag = FactoryBot.create(:tag)
          exercise_tagging = FactoryBot.create(:exercise_tagging, exercise: exercise, tag: tag)
          doctrine = FactoryBot.create(:doctrine)
          doctrine_tagging = FactoryBot.create(:doctrine_tagging, tag: tag, doctrine: doctrine)
          doctrines_for_first_tag = [doctrine]

          get :show, id: exercise.id
          doctrines_ivar = assigns(:doctrines)

          expect(doctrines_ivar).to eq(doctrines_for_first_tag)
        end
      end
    end
  end
end
