class Education < ApplicationRecord
  belongs_to :candidate

  validates :institution_name, :degree, :start_date, :end_date, presence: true

  # Other validations and methods
end
