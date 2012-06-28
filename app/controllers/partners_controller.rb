class PartnersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :create, :destroy]
  before_filter :correct_user,   only: :destroy

  def index
  end

  def create
    @partner = current_user.partners.build(params[:partner])
    if @partner.save
      flash[:success] = "Parceiro criado!"
      redirect_to root_path
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @partner.destroy
    redirect_to root_path
  end

  private
    def correct_user
      @partner = current_user.partners.find_by_id(params[:id])
      redirect_to root_path if @partner.nil?
    end
end
