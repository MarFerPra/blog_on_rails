class SessionsController < ApplicationController
  def new
  end

  def create
    run User::Authenticate do |op|
      if(op.user.nil?)
        flash.now[:error] = "Invalid email/password combination."
        render 'new'
      else
        sign_in op.user
        redirect_to op.user
      end
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end

end
