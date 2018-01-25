class ReferralsController < ApplicationController
  def show
  end

  def bind_recipient

    unless params[:email].nil?
      recipient = User.find_by_email(params[:email])
      referral = Referral.find_by_referral_token(params[:referral_token])

      return if referral.nil? || recipient.nil?

      referral.update_attribute(:to_user_id, recipient.id)
    end

    redirect_to root_path

  end


end
