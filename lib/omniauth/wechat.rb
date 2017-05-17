require 'omniauth-oauth2'


module OmniAuth
  module Strategies
    class Wechat < OmniAuth::Strategies::OAuth2

      def raw_info
        @uid ||= access_token["openid"]
        @raw_info ||= begin
          access_token.options[:mode] = :query
          response = access_token.get("/sns/userinfo", :params => {"openid" => @uid}, parse: :text)
          @raw_info = JSON.parse(response.body.gsub(/[\u0000-\u001f]+/, ''))
        end
      end
    end
  end
end