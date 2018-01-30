# frozen_string_literal: true

RSpec.describe UserMailer, type: :mailer do
  describe 'when user subscribe category' do
    let(:user) { FactoryBot.create(:random_user) }
    let!(:category) { FactoryBot.create(:fake_category) }
    let(:mail) { described_class.subscribe_email(user.id).deliver_now }

    before { user.categories << category }

    it 'renders the subject' do
      expect(mail.subject).to eq('Subscribtion to new category!')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([user.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(['amazing2gallery@gmail.com'])
    end

    it 'assigns name' do
      expect(mail.body.encoded).to match(user.name)
    end

    it 'check content of email' do
      expect(mail.body.encoded)
        .to match('You are subscribe to category ' + category.name)
    end
  end
end
