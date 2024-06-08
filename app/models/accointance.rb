class Accointance < ApplicationRecord
  belongs_to :follower, class_name: 'User', foreign_key: 'follower_id'
  belongs_to :recipient, class_name: 'User', foreign_key: 'recipient_id'
end
