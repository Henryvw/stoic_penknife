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

          binding.pry
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
  #    it 'assigns the return value of exercise#rehearsals_for_user to the rehearsals ivar' do
  #      exercise = FactoryBot.create(:exercise)
  #      allow(Exercise).to receive(:find).with(exercise.id.to_s).and_return(exercise)
  #
  #      rehearsals_for_user = double('rehearsals_for_user')
  #      allow(exercise).to receive(:rehearsals_for_user).with(user).and_return(rehearsals_for_user)
  #
  #      get :show, id: exercise.id
  #      rehearsals_ivar = assigns(:rehearsals)
  #
  #      expect(rehearsals_ivar).to eq(rehearsals_for_user)
  #    end
  #
  #    context 'when the exercise has no tags' do
  #      it 'doctrines ivar is nil' do
  #        exercise = FactoryBot.create(:exercise)
  #
  #        get :show, id: exercise.id
#        doctrines_ivar = assigns(:doctrines)
#
#        expect(doctrines_ivar).to be_nil
#      end
#    end
#
#    context 'when the exercise has tags' do
#      it 'tags ivar is set to the exercises ivars tags' do
#        exercise = FactoryBot.create(:exercise)
#        # Rubocop didn't like all the unused 'exercise_taggings"... apparently I'm not even using them at all for any kind of test
#        # tag = FactoryBot.create(:tag)
#        # exercise_tagging = FactoryBot.create(:exercise_tagging, exercise: exercise, tag: tag)
#        exercise_tags = [tag]
#
#        get :show, id: exercise.id
#        tags_ivar = assigns(:tags)
#
#        expect(tags_ivar).to eq(exercise_tags)
#      end
#
#      context 'when the first tag associated with an exercise has no doctrines' do
#        it 'sets the doctrines ivar to be empty' do
#          exercise = FactoryBot.create(:exercise)
#          # tag = FactoryBot.create(:tag)
#          # exercise_tagging = FactoryBot.create(:exercise_tagging, exercise: exercise, tag: tag)
#
#          get :show, id: exercise.id
#          doctrines_ivar = assigns(:doctrines)
#
#          expect(doctrines_ivar).to be_empty
#        end
#      end
#
#      context 'when the first tag associated with an exercise has doctrines' do
#        it 'sets the doctrines ivar to the doctrines associated with the first tag' do
#          exercise = FactoryBot.create(:exercise)
#          # tag = FactoryBot.create(:tag)
#          # exercise_tagging = FactoryBot.create(:exercise_tagging, exercise: exercise, tag: tag)
#          doctrine = FactoryBot.create(:doctrine)
#          # doctrine_tagging = FactoryBot.create(:doctrine_tagging, tag: tag, doctrine: doctrine)
#          doctrines_for_first_tag = [doctrine]
#
#          get :show, id: exercise.id
#          doctrines_ivar = assigns(:doctrines)
#
#          expect(doctrines_ivar).to eq(doctrines_for_first_tag)
#        end
#      end
#    end
#   end
end
