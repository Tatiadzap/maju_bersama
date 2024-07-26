class JobsController < ApplicationController
  # include Auth
  before_action :set_event, only: %i[ show ]

  def index
    @jobs = Job.includes(employer: :user).all.as_json(
      include: {
        employer: {
          only: [:id, :company_name],
          include: {
            user: { only: [:id, :profile_picture] } # Adjust the attributes to include as necessary
          }
        }
      }
    )
  end

  def show
    fetch_employer
    fetch_employer_logo
    raise
  end

  # def new
  #   @job = Job.new
  # end

  # def create
  #   job = Job.new(event_params)
  #   if job.save
  #     redirect_to events_path, notice: 'Job created.'
  #   else
  #     redirect_to new_event_path, inertia: { errors: job.errors }
  #   end
  # end

  # def edit
  # end

  # def update
  #   if @job.update(event_params)
  #     redirect_to events_path, notice: 'Job was successfully updated.'
  #   else
  #     redirect_to edit_event_path(@job), inertia: { errors: @job.errors }
  #   end
  # end

  # def destroy
  #   @job.destroy
  #   redirect_to events_path, notice: 'Job was successfully deleted.'
  # end

  private

  def set_event
    @job = Job.find(params[:id])
  end

  # def event_params
  #   params.fetch(:job, {}).permit(:title, :description, :start_date)
  # end
  #
  def fetch_employer
    @employer = Employer.find(@job.employer_id)
  end

  def fetch_employer_logo
    @company_logo = @employer.user.profile_picture
  end
end
