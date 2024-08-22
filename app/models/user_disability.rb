class UserDisability < ApplicationRecord
  belongs_to :user
  belongs_to :disability

  # Other validations and methods
  validate :unique_user_disability

  private

  def unique_user_disability
    if UserDisability.where(user_id: user_id, disability_id: disability_id).exists?
      errors.add(:disability_id, 'This disability has already been assigned to the user.')
    end
  end
end
