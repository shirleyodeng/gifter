class GiftsController < ApplicationController
  before_action :set_gift, only: [:show, :edit, :update, :destroy]

  def index
    @gifts = policy_scope(Gift)
    @event = Event.find(params[:event_id])
    @invite = Invite.new
  end

  def show
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
    raise
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
