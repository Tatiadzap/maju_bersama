class Skill < ApplicationRecord
  has_many :candidate_skills, dependent: :destroy
  has_many :candidates, through: :candidate_skills

  validates :skill_name, presence: true

  # Other validations and methods
end
