class Application < ApplicationRecord
  belongs_to :user
  belongs_to :job

  validates :status, :applied_at, presence: true

  # Other validations and methods
end
