class Event < ApplicationRecord
  belongs_to :employer
  has_many :event_registrations, dependent: :destroy

  validates :name, :start_time, :end_time, presence: true

  # Other validations and methods
end
