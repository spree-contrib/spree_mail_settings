require 'spec_helper'

describe Spree::Admin::MailMethodsController, type: :controller do
  stub_authorization!

  let!(:store) { create(:store) }

  context '#update' do
    before do
      spree_put :update, enable_mail_delivery: '1'
    end

    it 'reinitializes the mail settings' do
      expect(response).to redirect_to(edit_admin_mail_method_url)
    end
  end

  context '#testmail' do
    let(:user) { create(:user, email: 'user@spree.com') }

    before do
      allow(controller).to receive(:try_spree_current_user).and_return(user)
      Spree::Config[:enable_mail_delivery] = '1'
    end

    def send_request
      spree_post :testmail
    end

    it 'can trigger testmail' do
      expect { send_request }.to change { ActionMailer::Base.deliveries.size }.by(1)
    end
  end
end
