class CandidateDisability < ApplicationRecord
  # belongs_to :user
  belongs_to :candidate
  belongs_to :disability

  # Other validations and methods
  validates :disability_id, presence: true
  validate :unique_candidate_disability

  private

  def unique_candidate_disability
    if CandidateDisability.exists?(candidate_id: candidate_id, disability_id: disability_id)
      errors.add(:base, "This candidate already has this disability.")
    end
  end
end
