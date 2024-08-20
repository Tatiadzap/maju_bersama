class JobApplication < ApplicationRecord
  belongs_to :user
  belongs_to :job

  validates :status, presence: true
  validates :job_id, presence: true
  validates :user_id, presence: true

  # Other validations and methods
end
