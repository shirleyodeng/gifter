class EventsController < ApplicationController
  before_action :set_event, only: [:show, :destroy]

  def index
    @events = policy_scope(Event)
    @upcoming_events = Guest.where(user: current_user)
    @invite = Invite.new
  end

  def new
    @event = Event.new
    authorize @event
  end

  def create
    @event = Event.new(event_params)
    @event.creator = current_user
    authorize @event
    @event.save
    redirect_to event_gifts_path(@event)
  end

  def destroy
    @event.destroy
    redirect_to events_path
  end

  private

  def set_event
    @event = Event.find(params[:id])
    authorize @event
  end

  def event_params
    params.require(:event).permit(:name, :date, :child_photo, :child_name, :account_name, :account_number, :sort_code)
  end
end
