# Allows us to intercept any outbound mail message and make last minute changes
# (such as specifying a "from" address or sending to a test email account)
#
# See http://railscasts.com/episodes/206-action-mailer-in-rails-3 for more details.
module Spree
  module Core
    class MailInterceptor
      def self.delivering_email(message)
        message.from ||= Config[:mails_from] if Config[:mails_from].present?

        if Config[:intercept_email].present?
          message.subject = "#{message.to} #{message.subject}"
          message.to = Config[:intercept_email]
        end

        message.bcc ||= Config[:mail_bcc] if Config[:mail_bcc].present?
      end
    end
  end
end
