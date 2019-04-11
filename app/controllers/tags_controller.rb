class TagsController < ApplicationController
  def index
    @global_exercises = Exercise.tagged_with(params[:tag]).where(global: true)
    @quotations = Quotation.tagged_with(params[:tag])
    @doctrines = Doctrine.tagged_with(params[:tag])
    if user_signed_in?
      @exercises = Exercise.tagged_with(params[:tag]).where(user_id: current_user.id)
    end
  end
end
