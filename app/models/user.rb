class User < ApplicationRecord
  has_many :sent_referrals, -> { order 'updated_at DESC' },
                          class_name: 'Referral',
                          foreign_key: 'from_user_id'

  has_many :received_referrals, class_name: 'Referral',
                                foreign_key: 'to_user_id'

  def total_reward_point
    sent_referrals.select(&:successful?).length
  end

  def sent_referral_count
    # exclude self referrals
    sent_referrals.reject(&:self_referral?).length
  end

  def first_name
    name.split(' ')[0]
  end

  def last_name
    name.split(' ')[1]
  end

  def activity_feeds
    sent_referrals.map(&:to_activity_feed)
  end

  def three_latest_feeds
    sent_referrals.first(3).map(&:to_activity_feed)
  end

end
