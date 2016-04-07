# We'll use the OrderMailer as a quick and easy way to test. IF it works here
# it works for all email (in theory.)
RSpec.describe Spree::OrderMailer do
  let!(:store) { create(:store) }
  let(:order) { Spree::Order.new(email: 'customer@example.com') }
  let(:message) { described_class.confirm_email(order) }

  before(:all) do
    ActionMailer::Base.perform_deliveries = true
    ActionMailer::Base.deliveries.clear
  end

  context '#deliver' do
    before do
      store.send(:clear_cache)
      ActionMailer::Base.delivery_method = :test
      Spree::Config[:intercept_email] = ''
    end

    after { ActionMailer::Base.deliveries.clear }

    it 'uses the from address specified in the store preference' do
      deliver message
      expect(@email.from).to match_array [store.mail_from_address]
    end

    it 'uses the provided from address' do
      message.from = 'override@foobar.com'
      message.to = 'test@test.com'
      deliver message
      expect(@email.from).to match_array ['override@foobar.com']
      expect(@email.to).to match_array ['test@test.com']
    end

    it 'adds the bcc email when provided' do
      Spree::Config[:mail_bcc] = 'bcc-foo@foobar.com'
      deliver message
      expect(@email.bcc).to match_array ['bcc-foo@foobar.com']
    end

    context 'when intercept_email is provided' do
      it 'strips the bcc recipients' do
        expect(message.bcc).to be_blank
      end

      it 'strips the cc recipients' do
        expect(message.cc).to be_blank
      end

      it 'replaces the receipient with the specified address' do
        Spree::Config[:intercept_email] = 'intercept@foobar.com'
        deliver message
        expect(@email.to).to match_array ['intercept@foobar.com']
      end

      it 'modifies the subject to include the original email' do
        Spree::Config[:intercept_email] = 'intercept@foobar.com'
        deliver message
        expect(@email.subject.match(/customer@example\.com/)).to be_truthy
      end
    end

    context 'when intercept_mode is not provided' do
      it 'does not modify the recipient' do
        Spree::Config[:intercept_email] = ''
        deliver message
        expect(@email.to).to match_array ['customer@example.com']
      end
    end

    def deliver(message)
      message.deliver_now
      @email = ActionMailer::Base.deliveries.first
    end
  end
end
