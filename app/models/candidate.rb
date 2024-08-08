class Candidate < ApplicationRecord
  belongs_to :user
  has_many :candidate_skills, dependent: :destroy
  has_many :skills, through: :candidate_skills
  has_many :educations, dependent: :destroy
  has_many :experiences, dependent: :destroy

  validates :first_name, :last_name, presence: true

  has_many :job_applications, foreign_key: :user_id, primary_key: :user_id
  # Other validations and methods
end
