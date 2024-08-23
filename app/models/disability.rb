class Disability < ApplicationRecord
  has_many :candidate_disabilities, dependent: :destroy
  has_many :candidates, through: :candidate_disabilities

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true

  # Other validations and methods
end
