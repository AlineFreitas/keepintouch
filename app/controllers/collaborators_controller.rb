class CollaboratorsController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user,     only: :destroy

  def index
    @collaborators = Collaborator.paginate(page: params[:page])
  end

  def show
    @collaborator = Collaborator.find(params[:id])
    @partners = @collaborator.partners.paginate(page: params[:page])
  end

  def new
    @collaborator = Collaborator.new
  end

  def create
    @collaborator = Collaborator.new(params[:collaborator])
    if @collaborator.save
      flash[:success] = "Colaborador cadastrado com sucesso!"
      redirect_to @collaborator
    else
      render 'new'
    end
  end

  def edit
    @collaborator = Collaborator.find(params[:id])
  end
  
  def update
    @collaborator = Collaborator.find(params[:id])
    if @collaborator.update_attributes(params[:collaborator])
      flash[:success] = "Profile updated"
      sign_in @collaborator
      redirect_to @collaborator
    else
      render 'edit'
    end
  end
  
  def destroy
    Collaborator.find(params[:id]).destroy
    flash[:success] = "Colaborador deletado."
    redirect_to collaborators_path
  end

  private
    def correct_user
      @collaborator = Collaborator.find(params[:id])
      redirect_to(root_path) unless current_user?(@collaborator)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
