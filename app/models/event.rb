class Event < ApplicationRecord
  belongs_to :employer
  has_many :event_registrations, dependent: :destroy
  has_many :applicants, through: :event_registrations, source: :user


  validates :name, :start_time, :end_time, presence: true
  validates :status, inclusion: { in: %w[Open Closed On_Hold Draft] }, presence: true

  def candidates
    event_registrations.includes(user: :candidate).map { |app| app.user.candidate }
  end

  def self.status_options
    %w[Open Closed On_Hold Draft]
  end
end
