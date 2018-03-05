class GiftsController < ApplicationController
  before_action :set_gift, only: [:show, :edit, :update, :destroy]

  def index
  end

  def show
  end

  def new
    @gift = Gift.new
  end

  def create
    @gift = Gift.new(gift_params)
    @gift.save
  end

  def edit
  end

  def update
  end

  def destroy
    @gift.destroy
  end

  private

  def set_gift
    @gift = Gift.find(params[:id])
    authorize @gift
  end

  def gift_params
    params.require(:gift).permit(:name, :description, :photo, :price)
  end
end
