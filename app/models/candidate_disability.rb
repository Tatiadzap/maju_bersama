class CandidateDisability < ApplicationRecord
  # belongs_to :user
  belongs_to :candidate
  belongs_to :disability

  # Other validations and methods
  validate :unique_candidate_disability

  private

  def unique_candidate_disability
    if CandidateDisability.where(candidate_id: candidate_id, disability_id: disability_id).exists?
      errors.add(:disability_id, 'This disability has already been assigned to the candidate.')
    end
  end
end
