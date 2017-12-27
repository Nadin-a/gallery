FactoryBot.define do
  factory :notification do
    user nil
    recipient_id 1
    action "MyString"
    notifiable_type "MyString"
    notifiable_id 1
  end
end
