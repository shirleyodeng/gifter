class EventsController < ApplicationController
  before_action :set_event, only: [:show, :destroy]

  def index
    @events = policy_scope(Event)
  end

  def show
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.save
  end

  def destroy
    @event.destroy
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
