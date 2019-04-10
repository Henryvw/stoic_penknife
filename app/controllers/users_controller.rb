# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!

  # Load CanCan roles for Controller
  load_and_authorize_resource

  # def index
  #   @users = User.all
  # end
end
