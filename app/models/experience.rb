class Experience < ApplicationRecord
  belongs_to :candidate

  validates :job_title, :company_name, :start_date, presence: true

  # Other validations and methods
end
