class Candidate < ApplicationRecord
  belongs_to :user
  has_many :candidate_skills
  has_many :skills, through: :candidate_skills
  has_many :educations
  has_many :experiences

  validates :first_name, :last_name, :date_of_birth, presence: true

  # Other validations and methods
end
