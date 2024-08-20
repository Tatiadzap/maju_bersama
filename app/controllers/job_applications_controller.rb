class JobApplicationsController < ApplicationController
  include Auth

  def index
    if current_user.role == 'candidate'
      @job_applications = JobApplication.includes(job: { employer: :user })
                                        .where(user_id: current_user.id)
                                        .order('job_applications.created_at DESC')
                                        .map do |application|
        application.as_json(
          include: {
            job: {
              only: [:id, :title, :location],
              include: {
                employer: {
                  only: [:id, :company_name],
                  include: {
                    user: { only: [:id, :profile_picture] }
                  }
                }
              }
            }
          }
        ).merge(
          application_status: application.status,
          created_at: application.created_at
        )
      end
    elsif current_user.role == 'employer'
      @job_applications = JobApplication.includes(user: :candidate, job: { employer: :user })
                                        .where(job: { employer_id: current_user.employer.id })
                                        .order('job_applications.created_at DESC')
                                        .map do |application|
        application.as_json(
          include: {
            job: {
              only: [:id, :title, :location],
              include: {
                employer: {
                  only: [:id, :company_name],
                  include: {
                    user: { only: [:id, :profile_picture] }
                  }
                }
              }
            },
            user: {
              only: [:id, :email],
              include: {
                candidate: { only: [:id, :first_name, :last_name] }
              }
            }
          }
        ).merge(
          application_status: application.status,
          applicant_name: "#{application.user.candidate.first_name} #{application.user.candidate.last_name}".strip,
          created_at: application.created_at
        )
      end
    else
      @job_applications = []
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

  def destroy
    @job_application = current_user.job_applications.find_by(job_id: params[:id])

    if @job_application
      @job_application.destroy
      render json: { message: 'unapplied' }, status: :ok
    else
      render json: { message: 'not_applied' }, status: :not_found
    end
  end

  private

  def job_application_params
    params.require(:job_application).permit(:job_id)
  end
end
