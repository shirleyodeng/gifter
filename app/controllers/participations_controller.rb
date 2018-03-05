class ParticipationsController < ApplicationController
  def show
    @participation = Participation.where(state: 'paid').find(params[:id])
  end

  def create
    gift = Gift.find(params[:gift_id])
    participation = Participation.create!(gift: teddy.sku, amount: gift.price, state: 'Pending')
    redirect_to new_participation_payment_path(order)
  end
end
