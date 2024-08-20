class Job < ApplicationRecord
  belongs_to :employer
  has_many :job_applications, dependent: :destroy
  has_many :applicants, through: :job_applications, source: :user

  validates :title, :description, :location, :requirements, presence: true
  validates :status, inclusion: { in: %w[Open Closed On_Hold Draft] }, presence: true

  # Return all candidate objects associated with this job
  def candidates
    job_applications.includes(user: :candidate).map { |app| app.user.candidate }
  end

  # Helper method to fetch status options
  def self.status_options
    %w[Open Closed On_Hold Draft]
  end
end
