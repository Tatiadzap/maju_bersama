class JobsController < ApplicationController
  include Auth

  before_action :set_job, only: %i[show edit update destroy]

  def index
    @jobs = fetch_jobs.map do |job|
      job.as_json(
        include: {
          employer: {
            only: [:id, :company_name],
            include: {
              user: { only: [:id, :profile_picture] }
            }
          }
        }
      ).merge(
        applied_by_current_user: current_user.role == 'candidate' && job_applied_by_current_user?(job.id)
      )
    end
  end
  def show
    @job_data = @job.as_json(
      include: {
        employer: {
          only: [:id, :company_name],
          include: {
            user: { only: [:id, :profile_picture] }
          }
        }
      }
    ).merge(
      applied_by_current_user: job_applied_by_current_user?(@job.id),
      company_details: @job.employer.user
    )

    render inertia: 'jobs/show', props: {
      job: @job_data
    }
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

  def edit
    @statuses = Job.status_options
  end

  def update
    if @job.update(job_params)
      redirect_to jobs_path, notice: 'Job was successfully updated.'
    else
      redirect_to edit_job_path(@job), inertia: { errors: @job.errors }
    end
  end

  def destroy
    @job.destroy
    redirect_to jobs_path, notice: 'Job was successfully deleted.'
  end

  private

  def set_job
    @job = Job.find(params[:id])
  end

  def job_params
    params.require(:job).permit(:title, :location, :description, :requirements)
  end

  def fetch_jobs
    if current_user.role == 'employer'
      current_user.employer.jobs.includes(employer: :user).order(:created_at)
    else
      Job.includes(employer: :user).order(:created_at)
    end
  end

  def job_applied_by_current_user?(job_id)
    current_user && JobApplication.exists?(job_id: job_id, user_id: current_user.id)
  end
end
