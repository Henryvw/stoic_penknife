require 'rails_helper'

RSpec.describe ExercisesController, type: :controller do
  describe '#index' do
    let(:exercise) { FactoryBot.create(:exercise, user_id: current_user.id) }
    let(:current_user) { FactoryBot.create(:user) }

    context 'As an authenticated user' do
      it 'returns the index successfully (200)' do
        allow(controller).to receive(:authenticate_user!)
        allow(controller).to receive(:current_user).and_return(current_user)

        get :index

        expect(response).to have_http_status '200'
      end
    end

    context 'As a guest' do
      it 'returns the index successfully (200)' do
        get :index
        expect(response).to have_http_status '200'
      end
    end
  end

  describe '#show' do
    let(:exercise) { FactoryBot.create(:exercise, user_id: current_user.id, global: true) }
    let(:current_user) { FactoryBot.create(:user) }

    context 'when logged in' do
      before do
        allow(controller).to receive(:authenticate_user!)
        allow(controller).to receive(:current_user).and_return(current_user)
      end

      it 'returns a 200 HTTP response code' do
        get :show, params: { id: exercise.id }
        expect(response).to have_http_status('200')
      end

      it 'raises an active record error if the exercise does not exist' do
        expect { get :show, params: { id: '2384' } }.to raise_error(ActiveRecord::RecordNotFound)
      end

      it 'blocks you (redirects you to root) from viewing a private, non-published/non-global exercise that does not belong to you' do
        not_my_exercise = FactoryBot.create(:exercise, user: create(:user), global: false)
        get :show, params: { id: not_my_exercise.id }
        expect(response).to redirect_to root_path
      end
    end

    context 'when not logged-in' do
      it 'allows you to see a global exercise' do
        get :show, params: { id: exercise.id }
        expect(response).to have_http_status('200')
      end

      it 'blocks (redirects) you from seeing a private exercise' do
        someones_private_exercise = FactoryBot.create(:exercise, user: create(:user), global: false)
        get :show, params: { id: someones_private_exercise.id }
        expect(response).to redirect_to root_path
      end
    end
  end

  describe '#edit' do
    context 'As a signed-in, non-admin user' do
      let(:current_user) { FactoryBot.create(:user) }
      let(:exercise) { FactoryBot.create(:exercise, user_id: current_user.id) }

      before do
        allow(controller).to receive(:authenticate_user!)
        allow(controller).to receive(:current_user).and_return(current_user)
      end

      it 'blocks you (redirects you to root) from editing an exercise that is PRIVATE and does not belong to you' do
        second_exercise = FactoryBot.create(:exercise, user: create(:user), global: false)
        get :edit, params: { id: second_exercise.id }
        expect(response).to redirect_to root_path
      end

      it 'blocks you (redirects you to root) from editing an exercise that is GLOBAL and does not belong to you' do
        second_exercise = FactoryBot.create(:exercise, user: create(:user), global: true)
        get :edit, params: { id: second_exercise.id }
        expect(response).to redirect_to root_path
      end
    end
  end

  describe '#create' do
    context 'as an authenticated, logged-in user' do
      let(:current_user) { FactoryBot.create(:user) }

      before do
        allow(controller).to receive(:authenticate_user!)
        allow(controller).to receive(:current_user).and_return(current_user)
      end

      context 'with valid attributes' do
        let(:question) { FactoryBot.create(:question)}
        let(:exercise) { FactoryBot.create(:exercise, user_id: current_user.id, questions: [question]) }

        it 'adds a new exercise' do
          exercise_params = FactoryBot.attributes_for(:exercise, questions_attributes: [build(:question).attributes], user_id: current_user.id)
          binding.pry
          expect { post :create, params: { exercise: exercise_params } }.to change(current_user.exercises, :count).by(1)
        end
      end

      context 'as a non-admin' do
        let(:exercise) { FactoryBot.create(:exercise, user_id: current_user.id) }

        it 'blocks you (redirects you to root) from creating an exercise that is GLOBAL' do
          allow(controller).to receive(:authenticate_user!)
          allow(controller).to receive(:current_user).and_return(current_user)

          global_exercise = FactoryBot.attributes_for(:exercise, global: true)
          get :create, params: { exercise: global_exercise }
          expect(response).to redirect_to root_path
        end
      end
    end

    context 'As a guest / not logged-in user' do
      it 'Blocks you (redirects you to sign_in) from creating an exercise' do
        get :new
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end

  describe '#update' do
    let(:exercise) { FactoryBot.create(:exercise, user_id: current_user.id) }
    let(:current_user) { FactoryBot.create(:user) }

    context 'as an authorized user' do
      context 'with valid attributes' do
        it 'updates an existing exercise' do
          allow(controller).to receive(:authenticate_user!)
          allow(controller).to receive(:current_user).and_return(current_user)

          updated_exercise_params = FactoryBot.attributes_for(:exercise, user_id: current_user.id, title: 'Senecas EVEN MORE + Updated with BONUS Material Courage Walk')
          patch :update, params: { exercise: updated_exercise_params, id: exercise.id }
          expect(exercise.reload.title).to eq 'Senecas EVEN MORE + Updated with BONUS Material Courage Walk'
        end
      end

      context 'as a non-admin' do
        it 'blocks you (redirects you to root) from updating an exercise to become GLOBAL' do
          allow(controller).to receive(:authenticate_user!)
          allow(controller).to receive(:current_user).and_return(current_user)

          global_exercise = FactoryBot.attributes_for(:exercise, global: true)
          patch :update, params: { exercise: global_exercise, id: exercise.id }
          expect(response).to redirect_to root_path
        end
      end
    end

    context 'As a guest / not logged-in' do
      it 'redirects you to the sign-in / sign-up page' do
        get :edit, params: { id: '' }
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end

  describe '#delete' do
    context 'as an authorized user' do
      # Note that for destroy/delete you need to use let! (exclamation mark)
      # because otherwise, if not already instantiated by another call,
      # the destroy action will try to destroy something that isn't there
      let!(:current_user) { FactoryBot.create(:user) }
      let!(:exercise) { FactoryBot.create(:exercise, user_id: current_user.id, global: false) }

      it 'successfully deletes an exercise' do
        allow(controller).to receive(:authenticate_user!)
        allow(controller).to receive(:current_user).and_return(current_user)

        expect { delete :destroy, params: { id: exercise.id } }.to change(Exercise, :count).by(-1)
      end
    end

    context 'as an unauthorized user' do
      it 'does NOT delete an exercise' do
        expect { delete :destroy, params: { id: 11 } }.to_not change(Exercise, :count)
      end
    end
  end
end
