class UserDisability < ApplicationRecord
  belongs_to :user
  belongs_to :disability

  validates :details, presence: true

  # Other validations and methods
end
