class Job < ApplicationRecord
  belongs_to :employer
  has_many :applications

  validates :title, :description, :location, :requirements, presence: true

  # Other validations and methods
end
