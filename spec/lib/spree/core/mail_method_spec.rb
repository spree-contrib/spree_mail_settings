RSpec.describe Spree::Core::MailMethod do
  let(:mail_method) { described_class.new }
  let(:mail) do
    Mail.new do
      from 'spree@example.com'
      to 'customer@example.com'
    end
  end

  context 'mail delivery enabled' do
    before { Spree::Config[:enable_mail_delivery] = true }

    it 'delivers the mail' do
      expect { mail_method.deliver!(mail) }.to change { ActionMailer::Base.deliveries.size }.by(1)
    end
  end

  context 'mail delivery disabled' do
    before { Spree::Config[:enable_mail_delivery] = false }

    it 'does not deliver the mail' do
      expect { mail_method.deliver!(mail) }.not_to change { ActionMailer::Base.deliveries.size }
    end
  end

  describe 'mailer uses custom settings' do
    subject { mail_method.mailer.settings }
    it { is_expected.to eq Spree::Core::MailSettings.new.mail_server_settings }
  end
end
