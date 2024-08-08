class JobApplication < ApplicationRecord
  belongs_to :user
  belongs_to :job
  has_one :candidate, through: :user

  validates :status, presence: true

  # Other validations and methods
end
