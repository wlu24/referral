class EmbedController < ApplicationController
  def show
    @sender_email = current_user.email
    referral = Referral.create(from_user: current_user)
    @referral_token = referral.referral_token
    @share_url = referrals_show_url(@referral_token)

    three_latest_feeds = current_user.three_latest_feeds
    @first_feed = three_latest_feeds[0] || ' '
    @second_feed = three_latest_feeds[1] || ' '
    @third_feed = three_latest_feeds[2] || ' '

    @total_reward_point = current_user.total_reward_point
  end
end
