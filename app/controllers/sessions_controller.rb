class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.authenticate(params[:session][:email],
    params[:session][:password])

    if user.nil?
      # Mensaje de error
    else
      # Inicio de sesion y redireccion al perfil del usuario
    end
  end

  def destroy
  end


end
