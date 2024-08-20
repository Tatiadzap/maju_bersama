class EventsController < ApplicationController
  include Auth

  # Ensure set_event is only called on actions that need it
  before_action :set_event, only: %i[show edit update destroy]

  def index
    @events = fetch_events.map do |event|
      event.as_json(
        include: {
          employer: {
            only: [:id, :company_name],
            include: {
              user: { only: [:id, :profile_picture] }
            }
          }
        }
      ).merge(
        registered_by_current_user: current_user.role == 'candidate' && event_registered_by_current_user?(event.id)
      )
    end
  end

  def show
    @event = Event.find(params[:id])
    @event_data = @event.as_json(
      include: {
        employer: {
          only: [:id, :company_name],
          include: {
            user: { only: [:id, :profile_picture] }
          }
        }
      }
    ).merge(
      registered_by_current_user: event_registered_by_current_user?(@event.id),
      company_details: @event.employer.user
    )

    render inertia: 'events/show', props: {
      event: @event_data
    }
  end


  def new
    @event = Event.new
  end

  def create
    @event = current_user.employer.events.new(event_params.merge(status: 'Open'))

    if @event.save
      redirect_to event_path(@event), notice: 'Event created.'
    else
      redirect_to new_event_path, inertia: { errors: @event.errors }
    end
  end

  def edit
    @statuses = Event.status_options
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
    params.require(:event).permit(:name, :description, :start_time, :end_time)
  end

  def fetch_events
    if current_user.role == 'employer'
      current_user.employer.events.includes(employer: :user).order(:created_at)
    else
      Event.includes(employer: :user).order(:created_at)
    end
  end

  def event_registered_by_current_user?(event_id)
    current_user && EventRegistration.exists?(event_id: event_id, user_id: current_user.id)
  end
end
