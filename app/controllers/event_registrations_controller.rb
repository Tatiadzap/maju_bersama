class EventRegistrationsController < ApplicationController
  include Auth

  def index
    if current_user.role == 'candidate'
      @event_registrations = EventRegistration.includes(event: { employer: :user })
                                              .where(user_id: current_user.id)
                                              .order('event_registrations.created_at DESC')
                                              .map do |registration|
        registration.as_json(
          include: {
            event: {
              only: [:id, :name, :location],
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
          registration_status: registration.status,
          created_at: registration.created_at
        )
      end
    elsif current_user.role == 'employer'
      @event_registrations = EventRegistration.includes(user: :candidate, event: { employer: :user })
                                              .where(event: { employer_id: current_user.employer.id })
                                              .order('event_registrations.created_at DESC')
                                              .map do |registration|
        registration.as_json(
          include: {
            event: {
              only: [:id, :name, :location],
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
          registration_status: registration.status,
          registrant_name: "#{registration.user.candidate.first_name} #{registration.user.candidate.last_name}".strip,
          created_at: registration.created_at
        )
      end
    else
      @event_registrations = []
    end
  end

  def create
    event_id = params[:event_registration][:event_id]
    user_id = current_user.id

    existing_registration = EventRegistration.find_by(event_id: event_id, user_id: user_id)

    if existing_registration
      render json: { message: 'already_registered' }, status: :unprocessable_entity
    else
      event_registration = EventRegistration.new(event_registration_params)
      event_registration.user_id = user_id
      event_registration.status = 'registered'

      if event_registration.save
        render json: { message: 'success' }, status: :created
      else
        render json: { errors: event_registration.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end

  private

  def event_registration_params
    params.require(:event_registration).permit(:event_id)
  end
end
