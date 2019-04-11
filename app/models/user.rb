class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :rehearsals
  has_many :exercises

  class MyMailer < Devise::Mailer
    # gives access to all helpers
    # defined within `application_helper`.
    helper :application
    include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`
  end
end
