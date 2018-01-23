class Referral < ApplicationRecord
  belongs_to :from_user, class_name: "User"
  belongs_to :to_user, class_name: "User"

  validates :from_user_id, presence: true
  validates :to_user_id, presence: true

  # validates :from_user_id, uniqueness: { scope: :to_user_id }

  def sender
    from_user.name
  end

  def recipient
    to_user.name
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
end
