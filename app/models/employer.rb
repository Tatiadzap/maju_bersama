class Employer < ApplicationRecord
  belongs_to :user
  has_many :events, dependent: :destroy
  has_many :jobs, dependent: :destroy

  validates :company_name, :industry, presence: true

  # Other validations and methods
end
