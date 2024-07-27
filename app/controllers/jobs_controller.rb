class JobsController < ApplicationController
  # include Auth
  before_action :set_job, only: %i[ show ]

  def index
    @jobs = Job.includes(employer: :user).all.map do |job|
      job.as_json(
        include: {
          employer: {
            only: [:id, :company_name],
            include: {
              user: { only: [:id, :profile_picture] }
            }
          }
        }
      ).merge(applied_by_current_user: job_applied_by_current_user?(job.id))
    end
  end

  def show
    fetch_employer
    @isApplied = job_applied_by_current_user?(@job.id)
  end

  private

  def set_job
    @job = Job.find(params[:id])
  end

  # def event_params
  #   params.fetch(:job, {}).permit(:title, :description, :start_date)
  # end
  #
  def fetch_employer
    @employer = Employer.find(@job.employer_id)
    @company_details = @employer.user
  end


  def job_applied_by_current_user?(job_id)
    JobApplication.exists?(job_id: job_id, user_id: current_user.id)
  end
end
