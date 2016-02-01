class User::Create < Trailblazer::Operation
  attr_accessor :user

  def process(params)
    @user = User.new(User.user_params(params))
    @user.save
  end
end
