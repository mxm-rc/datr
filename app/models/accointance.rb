class Accointance < ApplicationRecord
  belongs_to :follower, class_name: 'User'
  belongs_to :recipient, class_name: 'User'
  has_many :meets, dependent: :destroy

  validates :follower_id, presence: true
  validates :recipient_id, presence: true
  validates :status, inclusion: { in: %w[pending accepted refused] }

  before_save :unique_accointance

  def friend_of(current_user)
    current_user == follower ? recipient : follower
  end

  def self.status_exist(user)
    Accointance.find_by(follower: user) || Accointance.find_by(recipient: user)
  end

  private

  def default_accointance_status
    self.status ||= 'pending'
  end

  def different_follower_recipient_id
    error.add(:base, "The Follower and Recipient must be different") if follower_id == recipient_id
  end

  def unique_accointance
    existing_accointance = Accointance.find_by(follower_id: follower_id, recipient_id: recipient_id) || Accointance.find_by(follower_id: recipient_id, recipient_id: follower_id)
    errors.add(:base, "An acquaintance request already exists for this pair") if existing_accointance
  end
end
