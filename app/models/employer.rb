class Employer < ApplicationRecord
  belongs_to :user
  has_many :events
  has_many :jobs

  validates :company_name, :industry, presence: true

  # Other validations and methods
end
