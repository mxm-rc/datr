class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  validates :address, presence: true
  validates :birth_date, presence: true
  validates :validate_age

  private

  def validate_age
    return if birth_date.present? && birth_date > 18.years.ago.to_d

    errors.add(:birth_date, 'You should be over 18 years old.')
  end
end
