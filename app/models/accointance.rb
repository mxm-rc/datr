class Accointance < ApplicationRecord
  belongs_to :follower, class_name: 'User'
  belongs_to :recipient, class_name: 'User'

  def friend_of(current_user)
    current_user == follower ? recipient : follower
  end
end
