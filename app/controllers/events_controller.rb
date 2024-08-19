class EventsController < ApplicationController
  include Auth
  before_action :set_event, only: %i[ show edit update destroy ]

  def index
    if current_user.role == 'employer'
      @events = current_user.employer.events.includes(employer: :user).order(:created_at).map do |event|
        event.as_json(
          include: {
            employer: {
              only: [:id, :company_name],
              include: {
                user: { only: [:id, :profile_picture] }
              }
            }
          }
        )
      end
    else
      @events = Event.includes(employer: :user).order(:created_at).map do |event|
        event.as_json(
          include: {
            employer: {
              only: [:id, :company_name],
              include: {
                user: { only: [:id, :profile_picture] }
              }
            }
          }
        ).merge(registered_by_current_user: event_registered_by_current_user?(event.id))
      end
    end
  end

  def show
    fetch_employer
    @isRegistered = event_registered_by_current_user?(@event.id)
  end

  def new
    @event = Event.new
  end

  def create
    event = Event.new(event_params)
    if event.save
      redirect_to events_path, notice: 'Event created.'
    else
      redirect_to new_event_path, inertia: { errors: event.errors }
    end
  end

  def edit
  end

  def update
    if @event.update(event_params)
      redirect_to events_path, notice: 'Event was successfully updated.'
    else
      redirect_to edit_event_path(@event), inertia: { errors: @event.errors }
    end
  end

  def destroy
    @event.destroy
    redirect_to events_path, notice: 'Event was successfully deleted.'
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.fetch(:event, {}).permit(:name, :description, :start_date)
  end

  def fetch_employer
    @employer = Employer.find(@event.employer_id)
    @company_details = @employer.user
  end

  def event_registered_by_current_user?(event_id)
    return false if current_user.nil?

    EventRegistration.exists?(event_id: event_id, user_id: current_user.id)
  end
end
