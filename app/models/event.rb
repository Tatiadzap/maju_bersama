class Event < ApplicationRecord
  belongs_to :employer
  has_many :event_registrations

  validates :name, :start_time, :end_time, presence: true

  # Other validations and methods
end
