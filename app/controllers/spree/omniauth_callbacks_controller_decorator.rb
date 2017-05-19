Spree::OmniauthCallbacksController.class_eval do
  def open_wechat
    if request.env['omniauth.error'].present?
      flash[:error] = I18n.t('devise.omniauth_callbacks.failure', kind: auth_hash['provider'], reason: Spree.t(:user_was_not_valid))
      redirect_back_or_default(root_url)
      return
    end

    authentication = Spree::UserAuthentication.find_by_provider_and_uid(auth_hash['provider'], auth_hash['uid'])

    if authentication.present? and authentication.try(:user).present?
      flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: auth_hash['provider'])
      sign_in_and_redirect :spree_user, authentication.user
    elsif spree_current_user
      spree_current_user.apply_omniauth(auth_hash)
      spree_current_user.save!
      flash[:notice] = I18n.t('devise.sessions.signed_in')
      redirect_back_or_default(account_url)
    else
      session[:omniauth] = auth_hash
      flash[:notice] = '请完成手机号注册。如果您的手机号已经注册，请先使用手机号登陆后再进行微信绑定。'
      redirect_to new_spree_user_registration_url
      return
    end

    if current_order
      user = spree_current_user || authentication.user
      current_order.associate_user!(user)
      session[:guest_token] = nil
    end
  end
end