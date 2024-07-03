class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :followers, class_name: 'Accointance', foreign_key: 'follower_id', dependent: :destroy
  has_many :recipients, class_name: 'Accointance', foreign_key: 'recipient_id', dependent: :destroy

  # has_many :accointances, ->(user) { unscope(where: :user_id).where('follower_id = :id OR recipient_id = :id', id: user.id) }, dependent: :destroy
  has_many :venue_preferences
  has_many :venue_categories, through: :venue_preferences

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  validates :address, presence: true
  validates :birthdate, presence: true
  validate :validate_age

  def accointances
    Accointance.where('follower_id = ? OR recipient_id = ?', id, id)
  end

  def accointance_with(other_user)
    accointances.find_by(recipient_id: other_user.id) || accointances.find_by(follower_id: other_user.id)
  end

  def friends(status: nil)
    User.where(id: accointances_for(status: status).pluck(:follower_id, :recipient_id).flatten).distinct.where.not(id: id)
  end

  private

  def accointances_for(status: nil)
    status.nil? ? accointances : accointances.where(status: status)
  end

  def validate_age
    return if birthdate.present? && birthdate < 18.years.ago.to_date

    errors.add(:birthdate, "You should be over 18 years old.")
  end
end
