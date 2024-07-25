class CandidateSkill < ApplicationRecord
  belongs_to :candidate
  belongs_to :skill

  # Other validations and methods
end
