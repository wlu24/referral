class ReferralsController < ApplicationController
  def show




    if referral.present?

      if referral.from_user == current_user
        flash[:message] = 'You tried to refer yourself! Whoops!'
        return redirect_to root_path({id: current_user.id})
      end

      referral.update_attribute(:visited, true)
      @referral_token = params[:referral_token]
    else
      render status: 404
    end
  end

  def bind_recipient

    unless params[:email].nil?
      recipient = User.find_by_email(params[:email])

      return if referral.nil? || recipient.nil?

      referral.update_attribute(:to_user_id, recipient.id)
    end

    redirect_to root_path

  end

  def update
    referral.update_attribute(:successful, true)

    redirect_to root_path
  end


  private

    def referral
      Referral.find_by_referral_token(params[:referral_token])
    end


end
