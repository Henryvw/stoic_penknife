class StoicMailer < ActionMailer::Base
  include Devise::Mailers::Helpers

  NET_HTTP_ERRORS =
    [
      Net::SMTPServerBusy,
      Net::SMTPSyntaxError,
      Net::SMTPFatalError,
      Net::SMTPUnknownError,
      Net::HTTPBadResponse,
      Net::ProtocolError,
      Timeout::Error
    ].freeze

  default from: 'henry.stoicpenknife@gmail.com'

  def confirmation_instructions(record, token, opts = {})
    @token = token
    devise_mail(record, :confirmation_instructions, opts)
  end

  def reset_password_instructions(record, token, _opts = {})
    @token = token
    begin
      devise_mail(
        record,
        :reset_password_instructions,
        from: 'henry@stoicpenknife.com'
      )
    rescue *NET_HTTP_ERRORS => e
      flash[:error] = e.message
    end
  end

  def unlock_instructions(record, token, opts = {})
    @token = token
    devise_mail(record, :unlock_instructions, opts)
  end
end
