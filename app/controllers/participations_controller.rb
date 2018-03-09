class ParticipationsController < ApplicationController
  before_action :set_participation, only: [:show, :update]

  def show
    unless @participation.state == "paid"
      redirect_to :root
    end
  end

  def create
    @gift = Gift.find(params[:gift_id])
    @participation = Participation.create!(user: current_user, gift: @gift, amount: @gift.price, state: 'pending')
    authorize @participation
    redirect_to new_participation_payment_path(@participation)
  end

  def update
    @participation.update(participation_params)
    redirect_to events_path
  end

  private

  def set_participation
    @participation = Participation.find(params[:id])
    authorize @participation
  end

  def participation_params
    params.require(:participation).permit(:gift_message)
  end
end
