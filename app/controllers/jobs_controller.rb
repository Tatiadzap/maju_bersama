class JobsController < ApplicationController
  # include Auth
  before_action :set_job, only: %i[show]

  def index
    @jobs = Job.includes(employer: :user).order(:created_at).map do |job|
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

  def new
    @job = Job.new
  end

  def create
    job = Job.new(job_params)
    job.employer = current_user.employer
    job.status = "Open" # Ensure this association is correct
    if job.save
      redirect_to job_path(job), notice: 'Job created.' # Redirect to the newly created job's show page
    else
      redirect_to new_job_path, inertia: { errors: job.errors }
    end
  end

  private

  def set_job
    @job = Job.find(params[:id])
  end

  def job_params
    params.require(:job).permit(:title, :location, :description, :requirements) # Use require to ensure job params
  end

  def fetch_employer
    @employer = Employer.find(@job.employer_id)
    @company_details = @employer.user
  end

  def job_applied_by_current_user?(job_id)
    return false if current_user.nil? # Ensure this returns false when no user

    JobApplication.exists?(job_id: job_id, user_id: current_user.id)
  end
end
