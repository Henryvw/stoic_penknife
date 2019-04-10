# frozen_string_literal: true

class StoicMailer < ActionMailer::Base
  include Devise::Mailers::Helpers

  default from: 'henry.stoicpenknife@gmail.com'

  def confirmation_instructions(record, token, opts = {})
    @token = token
    devise_mail(record, :confirmation_instructions, opts)
  end

  def reset_password_instructions(record, token, opts = {})
    @token = token
    devise_mail(record, :reset_password_instructions, opts)
  end

  def unlock_instructions(record, token, opts = {})
    @token = token
    devise_mail(record, :unlock_instructions, opts)
  end
end
