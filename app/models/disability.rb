class Disability < ApplicationRecord
  has_many :user_disabilities, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true

  # Other validations and methods
end
