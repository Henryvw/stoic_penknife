class RehearsalsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_rehearsal, only: %i[show edit update destroy]
  before_action :fetch_city, only: %i[new]

  # Load CanCan roles for Controller
  load_and_authorize_resource

  # GET /rehearsals
  # GET /rehearsals.json
  def index
    @rehearsals = Rehearsal.where(user_id: current_user.id)
  end

  # GET /rehearsals/1
  # GET /rehearsals/1.json
  def show
    @exercise = @rehearsal.exercise
  end

  # GET /rehearsals/new
  def new
    @exercise = Exercise.find(params[:exercise])
    @rehearsal = @exercise.rehearsals.new
    e_questions = @rehearsal.exercise.e_questions
    e_questions.each do |e_question|
      @rehearsal.e_answers.build(e_question_id: e_question.id)
    end

    exercise_tags = @exercise.tags
    @published_quotations = Quotation.where(publish: true)
                                     .find_quotations_with(exercise_tags)
  end

  # GET /rehearsals/1/edit
  def edit
    @exercise = @rehearsal.exercise
  end

  # POST /rehearsals
  # POST /rehearsals.json
  def create
    @rehearsal = Rehearsal.new(rehearsal_params)
    @rehearsal.user_id = current_user.id
    respond_to do |format|
      if @rehearsal.save
        format.html do
          redirect_to @rehearsal.exercise,
                      notice: 'Rehearsal was successfully created.'
        end
      else
        format.html { render action: 'new' }
      end
    end
  end

  # PATCH/PUT /rehearsals/1
  # PATCH/PUT /rehearsals/1.json
  def update
    if @rehearsal.update(rehearsal_params)
      redirect_to @rehearsal.exercise,
        notice: 'Rehearsal was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /rehearsals/1
  # DELETE /rehearsals/1.json
  def destroy
    @rehearsal.destroy
    respond_to do |format|
      format.html { redirect_to @rehearsal.exercise }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_rehearsal
    @rehearsal = Rehearsal.find(params[:id])
  end

  def fetch_city
    @rehearsal_location = request.location.city unless request.location.nil?
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def rehearsal_params
    params.require(:rehearsal).permit(:tally,
                                      :exercise_id,
                                      :city,
                                      e_answers_attributes: %i[
                                        id
                                        answer
                                        e_question_id
                                        _destroy
                                      ])
  end
end
