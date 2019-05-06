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

        aggregate_failures do
          expect(response).to be_success
          expect(response).to have_http_status "200"
        end
      end
    end

    context 'As a guest' do
      it 'redirects you to the sign-in / sign-up page' do
        get :index
        expect(response).to redirect_to '/users/sign_in'
      end

      it 'returns a 302 (redirect) response' do
        get :index
        expect(response).to have_http_status "302"
      end
    end
  end

  describe '#show' do
    let(:exercise) { FactoryBot.create(:exercise, user_id: current_user.id) }
    let(:current_user) { FactoryBot.create(:user) }

    context 'when logged in' do
      before do
        allow(controller).to receive(:authenticate_user!)
        allow(controller).to receive(:current_user).and_return(current_user)
      end

      it 'responds successfully to a GET request' do
        get :show, params: { id: exercise.id }
        expect(response).to be_success
      end

      it 'returns a 200 HTTP response code' do
        get :show, params: { id: exercise.id }
        expect(response).to have_http_status('200')
      end

      it 'raises an active record error if the exercise does not exist' do
        expect { get :show, params: { id: '2384' } }.to raise_error(ActiveRecord::RecordNotFound)
      end

      it 'blocks you (redirects you to root) from viewing a private, non-published/non-global exercise that does not belong to you' do
        not_my_exercise = FactoryBot.create(:exercise, user_id: 35, global: false)
        get :show, params: { id: not_my_exercise.id }
        expect(response).to redirect_to root_path
      end
    end

    context 'when not logged-in' do
      it 'returns a 302 response' do
        get :show, params: { id: exercise.id }
        expect(response).to have_http_status('302')
      end

      it 'redirects to the sign-in page' do
        get :show, params: { id: exercise.id }
        expect(response).to redirect_to('/users/sign_in')
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
        second_exercise = FactoryBot.create(:exercise, user_id: 35, global: false)
        get :edit, params: { id: second_exercise.id }
        expect(response).to redirect_to root_path
      end

      it 'blocks you (redirects you to root) from editing an exercise that is GLOBAL and does not belong to you' do
        second_exercise = FactoryBot.create(:exercise, user_id: 35, global: true)
        get :edit, params: { id: second_exercise.id }
        expect(response).to redirect_to root_path
      end

      it 'does not allow you to publish an exercise globally' do
        post :update, params: { exercise: { global: true }, id: exercise.id }
        expect(response).to redirect_to root_path
      end
    end
  end


  describe '#create' do
    context 'as an authenticated, logged-in user' do
        let(:current_user) { FactoryBot.create(:user) }


      context 'with valid attributes' do
        let(:exercise) { FactoryBot.create(:exercise, user_id: current_user.id) }

        it 'adds a new exercise' do
          allow(controller).to receive(:authenticate_user!)
          allow(controller).to receive(:current_user).and_return(current_user)

          exercise_params = FactoryBot.attributes_for(:exercise, user_id: current_user.id)
          post :create, params: { exercise: exercise_params }
          expect { post :create, params: { exercise: exercise_params } }.to change(current_user.exercises, :count).by(1)
        end
      end

      context 'as a non-admin a Global exercise' do
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

    context 'As a guest / not logged-in' do
      it 'redirects you to the sign-in / sign-up page' do
        get :index
        expect(response).to redirect_to '/users/sign_in'
      end

      it 'returns a 302 (redirect) response' do
        get :index
        expect(response).to have_http_status '302'
      end
    end
  end
