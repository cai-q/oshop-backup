Spree::User.class_eval do
  devise :database_authenticatable, :authentication_keys => [:phone]
  validates :phone, presence: true, uniqueness: true

  def email_required?
    false
  end

  def email_changed?
    false
  end

  def apply_omniauth(omniauth)
    skip_signup_providers = SpreeSocial::OAUTH_PROVIDERS.map { |p| p[1] if p[2] == 'true' }.compact
    if skip_signup_providers.include? omniauth['provider']
      self.email = omniauth['info']['email'] if email.blank?
    end
    user_authentications.build(
        provider: omniauth['provider'],
        uid: omniauth['uid'],
        openid: omniauth['extra']['raw_info']['openid'],
        sex: omniauth['extra']['raw_info']['sex'],
        language: omniauth['extra']['raw_info']['language'],
        city: omniauth['extra']['raw_info']['city'],
        province: omniauth['extra']['raw_info']['province'],
        country: omniauth['extra']['raw_info']['country'],
        headimgurl: omniauth['extra']['raw_info']['headimgurl'],
        unionid: omniauth['extra']['raw_info']['unionid'],
    )
  end
end