# frozen_string_literal: true

RSpec.describe ReportMailer, type: :mailer do
  describe 'when report send' do
    let(:user) { FactoryBot.create(:random_user) }
    let(:mail) { described_class.report_about_parsing(user.email, { all: 5, succeed: 5, errors: 0 }, []).deliver_now }

    it 'renders the subject' do
      expect(mail.subject).to eq('Report about uploading of pictures')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([user.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(['amazing2gallery@gmail.com'])
    end

    it 'check content of email' do
      expect(mail.body.encoded)
      .to match('All requested images:')
    end
  end
end
