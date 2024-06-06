class Accointance < ApplicationRecord
  belongs_to :follower, class_name: 'User'
  belongs_to :recipient, class_name: 'User'
end
