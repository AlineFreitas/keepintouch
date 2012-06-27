class SessionsController < ApplicationController
  def new
  end

  def create
    collaborator = Collaborator.find_by_email(params[:session][:email])
    if collaborator && collaborator.authenticate(params[:session][:password])
      sign_in collaborator
      redirect_back_or collaborator
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
