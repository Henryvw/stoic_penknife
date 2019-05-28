class DoctrinesController < ApplicationController
  # Load CanCan roles for Controller
  load_and_authorize_resource

  def index
    @doctrines = Doctrine.all
  end

  def new
    @doctrine = Doctrine.new
  end

  def create
    @doctrine = Doctrine.new(doctrine_params)
    @doctrine.save
    redirect_to doctrines_new_path
  end

  def show
  end

  def doctrine_params
    params.require(:doctrine).permit(:file_name, :tag_list, :publish)
  end
end
