class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.authenticate(params[:session][:email],
    params[:session][:password])

    if user.nil?
      # Mensaje de error
      flash.now[:error] = "Invalid email/password combination."
      render 'new'
    else
      # Inicio de sesion y redireccion al perfil del usuario
      sign_in user
      redirect_to user
    end
  end

  def destroy
  end


end
