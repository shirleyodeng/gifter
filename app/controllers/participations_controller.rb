class ParticipationsController < ApplicationController
  def show
    @participation = Participation.find(params[:id])
    unless @participation.state == "paid"
      redirect_to :root
    end
    authorize @participation
  end

  def create
    @gift = Gift.find(params[:gift_id])
    @participation = Participation.create!(user: current_user, gift: @gift, amount: @gift.price, state: 'pending')
    authorize @participation
    redirect_to new_participation_payment_path(@participation)
  end
end
