class EventRegistration < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :status, presence: true
  validates :event_id, presence: true
  validates :user_id, presence: true
  # Other validations and methods
end
