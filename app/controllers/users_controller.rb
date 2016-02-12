# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  name               :string
#  email              :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  encrypted_password :string
#  salt               :string
#

class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    run User::Create do |op|
      sign_in op.user
      return redirect_to (op.user)
      @user = op.user
    end
    render 'new'
  end

  def update
    run User::Update do |op|
      return redirect_to( op.user )
    end
  end

end
