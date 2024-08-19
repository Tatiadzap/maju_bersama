class EventRegistration < ApplicationRecord
  belongs_to :user
  belongs_to :event
  # Other validations and methods
end
