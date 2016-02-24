class User::Destroy < Trailblazer::Operation
  def process(params)
    @user = User.find(params[:id])
    @user.destroy
  end
end
