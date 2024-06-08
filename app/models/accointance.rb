class Accointance < ApplicationRecord
  belongs_to :follower, class_name: 'User'
  belongs_to :recipient, class_name: 'User'

  validates :follower_id, presence: true
  validates :recipient_id, presence: true
  validates :status, inclusion: { in: %w[pending accepted refused] }
  validate :different_follower_recipient_id

  private

  def default_accointance_status
    self.status ||= 'pending'
  end

  def different_follower_recipient_id
    error.add(:base, "The Follower and Recipient must be different") if follower_id == recipient_id
  end
end
