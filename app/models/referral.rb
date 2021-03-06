class Referral < ApplicationRecord
  belongs_to :from_user, class_name: "User"
  # belongs_to :to_user, class_name: "User"

  validates :from_user_id, presence: true
  # validates :to_user_id, presence: true

  # validates :from_user_id, uniqueness: { scope: :to_user_id }
  has_secure_token :referral_token

  def sender
    from_user.name
  end

  def recipient
    # to_user.name
    (to_user_id.nil?) ? 'A friend' : Referral.find(to_user_id).name
  end

  def self_referral?
    from_user_id == to_user_id
  end

  def link_clicked
    self.visited = true
    save
  end

  def purchase_made
    self.successful = true
    save
  end

  def to_activity_feed
    if self_referral?
      self_referral_text
    elsif successful
      purchase_text
    elsif visited
      visit_text
    else
      not_visited_text
    end
  end

  def successful?
    !self_referral? && successful
  end

  def visited?
    visited
  end


  private

    def self_referral_text
      'You tried to refer yourself! Whoops!'
    end

    def visit_text
      #"A friend visited your link, but didn't earn you a reward!"
      "#{recipient_in_feed_message} visited your link, but didn't earn you a reward!"
    end

    def purchase_text
      #"Your friend #{recipient} earned you a reward!"
      "#{recipient_in_feed_message} earned you a reward!"
    end

    def not_visited_text
      #"Your friend #{recipient} has not clicked the referral link yet!"
      "#{recipient_in_feed_message} has not clicked the referral link yet!"
    end

    def recipient_in_feed_message
      return 'A friend' if to_user_id.nil?

      friend = User.find(to_user_id).name
      "Your friend #{friend}"
    end
end
