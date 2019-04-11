class TagsController < ApplicationController
  before_action :grab_global_exercises,
                :grab_private_exercises,
                :grab_quotations,
                :grab_doctrines

  def index
  end

  def grab_global_exercises
    @global_exercises = Exercise.tagged_with(params[:tag])
                                .where(global: true)
  end

  def grab_private_exercises
    @exercises = Exercise.tagged_with(params[:tag])
                         .where(user_id: current_user.id) if user_signed_in?
  end

  def grab_quotations
    @quotations = Quotation.tagged_with(params[:tag])
  end

  def grab_doctrines
    @doctrines = Doctrine.tagged_with(params[:tag])
  end
end
