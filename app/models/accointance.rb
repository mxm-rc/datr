class Accointance < ApplicationRecord
  belongs_to :follower, class_name: 'User'
  belongs_to :recipient, class_name: 'User'
  has_many :meets, dependent: :destroy

  validates :follower_id, presence: true
  validates :recipient_id, presence: true
  validates :status, inclusion: { in: %w[pending accepted refused] }
  # validate :different_follower_recipient_id
  # validate :unique_acquaintance

  def friend_of(current_user)
    current_user == follower ? recipient : follower
  end

  private

  def default_accointance_status
    self.status ||= 'pending'
  end

  def different_follower_recipient_id
    error.add(:base, "The Follower and Recipient must be different") if follower_id == recipient_id
  end

  def unique_acquaintance
    existing_acquaintance = Accointance.find_by(follower_id: follower_id, recipient_id: recipient_id) ||
                            Accointance.find_by(follower_id: recipient_id, recipient_id: follower_id)
    errors.add(:base, "An acquaintance request already exists for this pair") if existing_acquaintance.present?
  end
end
