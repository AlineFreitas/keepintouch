class CollaboratorsController < ApplicationController
  def show
    @collaborator = Collaborator.find(params[:id])
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
  end
  
  def update
  end
  
  def destroy
  end
end
