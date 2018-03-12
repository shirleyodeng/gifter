class GiftsController < ApplicationController
  before_action :set_gift, only: [:edit, :update, :destroy]

  def index
    @participation = Participation.new
    @event = Event.find(params[:event_id])
    @gifts = @event.gifts
    @gifts = policy_scope(@gifts)
    if @event.guests.where(user: current_user).present? || @event.creator == current_user
      @invite = Invite.new
    else
      redirect_to root_path
    end
  end

  def new
    @gift = Gift.new
    @event = Event.find(params[:event_id])
    authorize @gift
  end

  def create
    @gift = Gift.new(gift_params)
    @event = Event.find(params[:event_id])
    @gift.event = @event
    authorize @gift
    @gift.save
    redirect_to event_gifts_path(@event)
  end

  def edit
  end

  def update
    @gift.update(gift_params)
    redirect_to event_gift_path(@gift)
  end

  def destroy
    @event = Event.find(params[:event_id])
    @gift.destroy
    redirect_to event_gifts_path(@event)
  end

  private

  def set_gift
    @gift = Gift.find(params[:id])
    authorize @gift
  end

  def gift_params
    params.require(:gift).permit(:name, :description, :photo, :photo_cache, :price)
  end
end
