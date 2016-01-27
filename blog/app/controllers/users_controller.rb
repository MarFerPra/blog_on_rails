# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string
#  email      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class UsersController < ApplicationController
  def new
    @user = User.new
  end

private
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

end
