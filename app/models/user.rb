class User < ApplicationRecord
  has_many :sent_referrals, class_name: 'Referral',
                            foreign_key: 'from_user_id'
  has_many :received_referrals, class_name: 'Referral',
                                foreign_key: 'to_user_id'
end
