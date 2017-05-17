Devise.secret_key = "09c548418de177d7a293d76ae069c4da762e6225ec47824da82c6013f2839480afcd10b99f52d9257356c8ae0513afdcc889"
#

# require 'omniauth/wechat'

# Rails.application.config.middleware.use OmniAuth::Builder do
#   provider :open_wechat, ENV['WX_OPEN_APPID'], ENV['WX_OPEN_APPSECRET']
# end

# overwrite fullhost for dev
# module OmniAuth
#   module Strategies
#     class OpenWechat < OmniAuth::Strategies::OAuth2
#       def callback_url
#         'http://rdev.com/users/auth/open_wechat/callback'
#       end
#     end
#   end
# end

module SpreeSocial
  def self.init_provider(provider, scope)
    return unless ActiveRecord::Base.connection.table_exists?('spree_authentication_methods')
    key, secret = nil
    Spree::AuthenticationMethod.where(environment: ::Rails.env).each do |auth_method|
      next unless auth_method.provider == provider
      key = auth_method.api_key
      secret = auth_method.api_secret
      Rails.logger.info("[Spree Social] Loading #{auth_method.provider.capitalize} as authentication source")
    end
    setup_key_for(provider.to_sym, key, secret, scope)
  end

  def self.setup_key_for(provider, key, secret, scope)
    Devise.setup do |config|
      config.omniauth provider, key, secret, setup: true, scope: scope, info_fields: 'email, name'
    end
  end
end


SpreeSocial::OAUTH_PROVIDERS << ['微信开放平台', 'open_wechat', 'true']
SpreeSocial.init_provider('open_wechat', 'snsapi_login')