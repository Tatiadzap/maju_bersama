class EventRegistration < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :registered_at, presence: true

  # Other validations and methods
end
