class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable, :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Validations
  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }, if: -> { new_record? || changes[:encrypted_password] }

  # Associations
  has_one :candidate, dependent: :destroy
  has_one :employer, dependent: :destroy
  has_many :job_applications, dependent: :destroy
  has_many :jobs, through: :job_applications
  has_many :event_registrations, dependent: :destroy
  has_many :jobs, through: :event_registrations
  has_many :user_disabilities, dependent: :destroy

  # Optional: Add additional validations or associations as needed
  #
  enum role: { candidate: 'candidate', employer: 'employer', admin: 'admin' }
end
