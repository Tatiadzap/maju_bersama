class JobApplicationsController < ApplicationController
  include Auth

  def create
    job_application = JobApplication.new(job_application_params)
    job_application.user_id = current_user.id

    if job_application.save
      render json: { message: 'Application submitted successfully' }, status: :created
    else
      render json: { errors: job_application.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def job_application_params
    params.require(:job_application).permit(:job_id, :user_id)
  end
end
