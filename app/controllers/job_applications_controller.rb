class JobApplicationsController < ApplicationController
  include Auth

  def index
    @job_applications = JobApplication.includes(job: { employer: :user })
                                      .where(user_id: current_user.id)
                                      .order('job_applications.created_at DESC')
                                      .map do |application|
      application.job.as_json(
        include: {
          employer: {
            only: [:id, :company_name],
            include: {
              user: { only: [:id, :profile_picture] }
            }
          }
        }
      ).merge(application_status: application.status)
    end
  end

  def create
    job_id = params[:job_application][:job_id]
    user_id = current_user.id

    existing_application = JobApplication.find_by(job_id: job_id, user_id: user_id)

    if existing_application
      render json: { message: 'already_applied' }, status: :unprocessable_entity
    else
      job_application = JobApplication.new(job_application_params)
      job_application.user_id = user_id
      job_application.status = 'applied'

      if job_application.save
        render json: { message: 'success' }, status: :created
      else
        render json: { errors: job_application.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end

  private

  def job_application_params
    params.require(:job_application).permit(:job_id)
  end
end
