# frozen_string_literal: true

RSpec.describe UserMailer, type: :mailer do
  describe 'when adding new image' do
    let(:user) { FactoryBot.create(:random_user) }
    let!(:category) { FactoryBot.create(:fake_category) }
    let!(:image) { FactoryBot.create(:random_image, category: category) }
    let(:mail) { described_class.new_image_email(user.id, image.id).deliver_now }

    before { user.categories << category }

    it 'renders the subject' do
      expect(mail.subject).to eq('New image in favorite category!')
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
        .to match('In your favorite category ' + category.name +
                ' was uploaded new image ' + image.title)
    end
  end
end
