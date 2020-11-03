module Spree
  module AppConfigurationDecorator
    def self.prepended(base)
      # Default mail headers settings
      base.preference :mails_from, :string, default: 'spree@example.com'
      base.preference :enable_mail_delivery, :boolean, default: false
      base.preference :mail_bcc, :string, default: 'spree@example.com'
      base.preference :intercept_email, :string, default: nil

      # Default smtp settings
      base.preference :mail_host, :string, default: 'localhost'
      base.preference :mail_domain, :string, default: 'localhost'
      base.preference :mail_port, :integer, default: 25
      base.preference :secure_connection_type, :string, default: ::Spree::Core::MailSettings::SECURE_CONNECTION_TYPES[0]
      base.preference :mail_auth_type, :string, default: ::Spree::Core::MailSettings::MAIL_AUTH[0]
      base.preference :smtp_username, :string, default: nil
      base.preference :smtp_password, :string, default: nil
    end

    def override_actionmailer_config
      raise 'override_actionmailer_config has been removed. ' \
              'actionmailer\'s config is always overwridden when spree_mail_settings is included'
    end

    alias_method :override_actionmailer_config=, :override_actionmailer_config
  end
end

::Spree::AppConfiguration.prepend(::Spree::AppConfigurationDecorator)
