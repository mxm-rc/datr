class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :followers, class_name: 'Accointance', foreign_key: 'follower_id', dependent: :destroy
  has_many :recipients, class_name: 'Accointance', foreign_key: 'recipient_id', dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  validates :address, presence: true
  validates :birthdate, presence: true
  validate :validate_age

  private

  def validate_age
    return if birthdate.present? && birthdate < 18.years.ago.to_date

    errors.add(:birthdate, "You should be over 18 years old.")
  end
end
