module Spree
  module Core
    class MailMethod
      def initialize(*)
      end

      def deliver!(mail)
        mailer.deliver!(mail) if Config.enable_mail_delivery
      end

      def mailer
        mailer_class.new(mail_server_settings)
      end

      private

      def mailer_class
        Rails.env.test? ? Mail::TestMailer : Mail::SMTP
      end

      def mail_server_settings
        MailSettings.new.mail_server_settings
      end
    end
  end
end
