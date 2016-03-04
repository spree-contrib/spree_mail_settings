module Spree
  module Admin
    class MailMethodsController < BaseController
      def update
        params[:smtp_password] = nil if params[:smtp_username].blank?

        params.each do |name, value|
          next unless Spree::Config.has_preference? name
          Spree::Config[name] = value
        end

        flash[:success] = Spree.t(:successfully_updated, resource: Spree.t(:mail_method_settings))
        redirect_to edit_admin_mail_method_url
      end

      def testmail
        if TestMailer.test_email(try_spree_current_user.email).deliver_now
          flash[:success] = Spree.t('mail_methods.testmail.delivery_success')
        else
          flash[:error] = Spree.t('mail_methods.testmail.delivery_error')
        end
      rescue => e
        flash[:error] = Spree.t('mail_methods.testmail.error', e: e)
      ensure
        redirect_to edit_admin_mail_method_url
      end
    end
  end
end
