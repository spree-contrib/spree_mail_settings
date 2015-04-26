RSpec.describe Spree::Core::MailSettings do
  describe 'mail_server_settings' do
    subject { described_class.new.mail_server_settings }
    let(:config) { Spree::Config }

    context 'authentication method is none' do
      before do
        config.mail_host = 'smtp.example.com'
        config.mail_domain = 'example.com'
        config.mail_port = 123
        config.mail_auth_type = described_class::SECURE_CONNECTION_TYPES[0]
        config.smtp_username = 'schof'
        config.smtp_password = 'hellospree!'
        config.secure_connection_type = 'TLS'
      end

      it { expect(subject[:address]).to eq 'smtp.example.com' }
      it { expect(subject[:domain]).to eq 'example.com' }
      it { expect(subject[:port]).to eq 123 }
      it { expect(subject[:authentication]).to eq 'None' }
      it { expect(subject[:enable_starttls_auto]).to be(true) }
      it { is_expected.not_to have_key(:user_name) }
      it { is_expected.not_to have_key(:password) }
    end

    context 'when mail_auth_type is other than none' do
      before do
        config.mail_auth_type = 'login'
        config.smtp_username = 'schof'
        config.smtp_password = 'hellospree!'
      end

      context 'overrides user credentials' do
        it { expect(subject[:user_name]).to eq 'schof' }
        it { expect(subject[:password]).to eq 'hellospree!' }
      end
    end
  end
end
