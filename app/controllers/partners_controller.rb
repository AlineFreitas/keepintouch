class PartnersController < ApplicationController
  before_filter :signed_in_user, only: [:new, :create, :destroy]
  before_filter :correct_user,   only: [:destroy]
  before_filter :admin_user, only: :index

  def index
    @partners = Partner.paginate(page: params[:page])
  end

  def new
    @partner = Partner.new
  end

  def create
    @collaborator = current_user
    @partner = @collaborator.partners.build(params[:partner])

    if @partner.save
      flash.now[:success] = "Parceiro criado!"
      redirect_to @partner
    else
      @feed_items = []
      render 'partners/new'
    end
  end

  def edit
    @collaborator = current_user
    @partner = @collaborator.partners.find(params[:id])
  end

  def update
    @collaborator = current_user
    @partner = @collaborator.partners.find(params[:id])

    if @partner.update_attributes(params[:partner])
      flash[:success] = "Dados atualizados!"
      redirect_to @partner
    else
      render 'edit'
    end
  end

  def show
    @partner = Partner.find(params[:id])
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
