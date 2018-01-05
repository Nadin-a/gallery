Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_ID'], ENV['FACEBOOK_SECRET'],
  provider_ignores_state: true,
  scope: 'email',
  info_fields: 'email'
end