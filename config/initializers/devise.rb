Devise.secret_key = "09c548418de177d7a293d76ae069c4da762e6225ec47824da82c6013f2839480afcd10b99f52d9257356c8ae0513afdcc889"
#
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :open_wechat, ENV['WX_OPEN_APPID'], ENV['WX_OPEN_APPSECRET'], {:scope => 'snsapi_login', :provider_ignores_state => true}
end

SpreeSocial::OAUTH_PROVIDERS << ['微信开放平台', 'open_wechat', 'true']
SpreeSocial.init_provider('open_wechat')