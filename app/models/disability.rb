class Disability < ApplicationRecord
  has_many :user_disabilities, dependent: :destroy

  validates :disability_name, presence: true

  # Other validations and methods
end
