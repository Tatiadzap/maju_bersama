class JobApplication < ApplicationRecord
  belongs_to :user
  belongs_to :job

  validates :status, presence: true

  # Other validations and methods
end
