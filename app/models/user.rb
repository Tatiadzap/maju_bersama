class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable, :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Validations
  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }, if: -> { new_record? || changes[:encrypted_password] }

  # Associations
  has_many :candidates, dependent: :destroy
  has_many :employers, dependent: :destroy
  has_many :applications, dependent: :destroy
  has_many :user_disabilities, dependent: :destroy

  # Optional: Add additional validations or associations as needed
end
