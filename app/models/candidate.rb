class Candidate < ApplicationRecord
  belongs_to :user
  has_many :candidate_skills, dependent: :destroy
  has_many :skills, through: :candidate_skills
  has_many :educations, dependent: :destroy
  has_many :experiences, dependent: :destroy

  validates :first_name, :last_name, presence: true

  # Other validations and methods
end
