class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    @current_user = User.third
  end

  def generate_unique_token
    while true
      token = SecureRandom.urlsafe_base64
      break token unless Referral.where(referral_token: token).exists?
    end
  end
end
